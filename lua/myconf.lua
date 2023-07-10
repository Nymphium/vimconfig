local vim = vim
local unpack = table.unpack or unpack
local api = vim.api

local pfx = function(c)
  return '<leader>l' .. c
end

local illuminate = require('illuminate')
local format = require 'lsp-format'
local nlspsettings = require("nlspsettings")
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers_fallback = { '.git' },
  append_default_schemas = true,
  loader = 'json'
})

-- code lens
local codelens = vim.api.nvim_create_augroup(
  'LSPCodeLens',
  { clear = true }
)

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  group = codelens,
  callback = vim.lsp.buf.clear_references,
})


do -- keymaps
  local opts = { noremap = true, silent = true }
  local set_keymap = function(...)
    return vim.keymap.set(...)
  end
  set_keymap("n", pfx 'k', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  set_keymap("n", pfx 'g', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  set_keymap("n", pfx 'i', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

  set_keymap("n", pfx '<F1>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  set_keymap("n", pfx 'f', "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  set_keymap("n", pfx 'fw', "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  set_keymap("n", pfx 'fl', "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  set_keymap("n", pfx 'r', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  set_keymap("n", pfx 'a', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  set_keymap('n', pfx 'e', "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  set_keymap("n", pfx 'b',
    "<cmd>lua vim.g.cq_prev_buf = vim.api.nvim_get_current_win(); vim.lsp.buf.references()<CR>", opts)

  set_keymap("n", '<leader><up>', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  set_keymap("n", '<leader><down>', "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  set_keymap("n", pfx 'q',
    "<cmd>lua vim.g.cq_prev_buf = vim.api.nvim_get_current_win(); vim.diagnostic.setloclist()<CR>", opts)

  set_keymap("n", pfx '=', "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)

  set_keymap("n", pfx 'n', [[<cmd>lua require"illuminate".next_reference{wrap=true}<cr>]], opts)
  set_keymap("n", pfx 'p', [[<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>]], opts)
end

do -- reference / diagnostic {{{
  vim.fn.sign_define('DiagnosticSignError',
    { text = '', texthl = 'DiagnosticError', linehl = '', numhl = 'DiagnosticVirtualTextError' })
  vim.fn.sign_define('DiagnosticSignWarn',
    { text = '', texthl = 'DiagnosticWarn', linehl = '', numhl = 'DiagnosticVirtualTextWarn' })
  vim.fn.sign_define('DiagnosticSignInfo',
    { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = 'DiagnosticVirtualTextInfo' })
  vim.fn.sign_define('DiagnosticSignHint',
    { text = '', texthl = 'DiagnosticHint', linehl = '', numhl = 'DiagnosticVirtualTextHint' })
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
  )
end -- }}}

do
  local on_attach = function(client, bufnr)
    illuminate.on_attach(client)

    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- api.nvim_buf_set_option(bufnr, 'completeopt', 'menu,menuone,noselect')

    return format.on_attach(client)
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local mason = require('mason')
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })

  local lspconfig = require "lspconfig"
  local mason_lspconfig = require('mason-lspconfig')
  local lsp_st = require('lsp_list')

  mason_lspconfig.setup_handlers({ function(server_name)
    return lspconfig[server_name].setup {
      capabilities = capabilities,
      lint = true,
      on_attach = on_attach
    }
  end })

  local eachconfig = vim.api.nvim_create_augroup(
    'LSPEachConfig',
    { clear = true }
  )

  api.nvim_create_autocmd('FileType', {
    group = eachconfig,
    pattern = '*',
    callback = function()
      local ft = vim.bo.filetype
      local st = lsp_st[ft]

      if st then
        local config = lspconfig[st[1]]

        if config then
          return config.setup {
            capabilities = capabilities,
            lint = true,
            on_attach = on_attach
          }
        end
      end
    end
  })
end

do -- completion
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local lspkind = require('lspkind')

  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  end

  local select_opts = { behavior = cmp.SelectBehavior.Select }

  cmp.setup {
    snippet = {
      expand = function(args)
        return luasnip.lsp_expand(args.body)
      end
    },
    mapping = {
      ["<Tab>"] = vim.schedule_wrap(function(fallback)
        if cmp.visible() and has_words_before() then
          return cmp.select_next_item(select_opts)
        else
          return fallback()
        end
      end),
      ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
        if cmp.visible() then
          return cmp.select_prev_item(select_opts)
        elseif luasnip.jumpable(-1) then
          return luasnip.jump(-1)
        else
          return fallback()
        end
      end, { "i", "s" }),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        select = false,
        behavior = cmp.ConfirmBehavior.Replace,
      })
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp',  keyword_length = 1, group_index = 1 },
      {
        name = 'buffer',
        keyword_length = 2,
        group_index = 3,
        options = {
          keyword_pattern = [[\k\+]]
        }
      },
      { name = 'luasnip',   keyword_length = 2 },
      { name = 'path',      group_index = 2 },
      { name = 'treesitter' },
      { name = 'git' },
      { name = "copilot",   keyword_length = 1, group_index = 2, max_item_count = 3, },
    },
    window = {
      completion = {
        border = "rounded",
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = { border = "rounded", },
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item = lspkind.cmp_format({
          mode = "symbol_text",
          symbol_map = {
            Copilot = "",
          },
          menu = {
            Copilot = "Copilot",
          }
        })(entry, vim_item)
        vim_item.abbr = string.format("%-s", vim_item.abbr)
        return vim_item
      end
    },
  }

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = "path" }
    }, {
      { name = 'buffer' },
    }, {
      { name = "copilot" }
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    view = {
      entries = { name = 'column' }
    },
    formatting = {
      fields = { 'abbr' },
      format = function(_, vim_item)
        return vim_item
      end
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    view = {
      entries = { name = 'column' }
    },
    formatting = {
      fields = { 'abbr' },
      format = function(_, vim_item)
        return vim_item
      end
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
end
