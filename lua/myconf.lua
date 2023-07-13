local vim = vim
local unpack = table.unpack or unpack
local api = vim.api

local pfx = function(c)
  return '<leader>l' .. c
end

local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()

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
  local signs = {
    Error = '',
    Warn = '',
    Info = '',
    Hint = ''
  }

  for level, symbol in pairs(signs) do
    local hl = 'DiagnosticSign' .. level

    vim.fn.sign_define(hl,
      {
        text = symbol,
        texthl = hl,
        linehl = '',
        numhl = 'DiagnosticVirtualText' .. level
      })
  end
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
  })
end -- }}}

do
  local illuminate = require('illuminate')
  local lspformat = require 'lsp-format'
  local on_attach = function(client, bufnr)
    illuminate.on_attach(client)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    return lspformat.on_attach(client)
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

  mason_lspconfig.setup_handlers({ function(server_name)
    return lspconfig[server_name].setup {
      capabilities = capabilities,
      lint = true,
      on_attach = on_attach,
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover,
          { border = 'rounded' }
        )
        ,
        ['textDocument/signatureHelp'] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = 'rounded' }
        ),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            signs = {
              severity_limit = "Hint",
            },
            virtual_text = {
              severity_limit = "Warning",
            },
          }
        )
      }
    }
  end })
end

do -- completion
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local lspkind = require('lspkind')

  cmp.event:on("menu_opened", function()
    local buf = vim.api.nvim_get_current_buf()

    vim.diagnostic.hide(nil, buf)
  end)

  cmp.event:on("menu_closed", function()
    local buf = vim.api.nvim_get_current_buf()

    vim.diagnostic.show(nil, buf)
  end)

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
      return vim.diagnostic.reset(nil, vim.api.nvim_get_current_buf())
    end
  })

  cmp.setup {
    experimental = { ghost_text = true },
    snippet = {
      expand = function(args)
        return luasnip.lsp_expand(args.body)
      end
    },
    mapping = {
      ["<Tab>"] = cmp.mapping({
        i = cmp.mapping.select_next_item(),
        c = function(fallback)
          local text = vim.fn.getcmdline()
          local expanded = vim.fn.expandcmd(text)
          if expanded ~= text then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, true, true) .. expanded, "n",
              false)
            return cmp.complete()
          else
            return cmp.select_next_item()
          end
        end
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          return luasnip.jump(-1)
        else
          return fallback()
        end
      end, { "i", "s", "c" }),
      ['<C-x>'] = cmp.mapping(function()
        return cmp.complete({
          config = {
            sources = {
              { name = "nvim_lsp", keyword_length = 0 },
              { name = "Copilot",  keyword_length = 0 } }
          }
        })
      end),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping({
        i = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        c = function(fallback)
          if cmp.visible() then
            local ent = cmp.get_selected_entry()

            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, })

            if ent then
              return cmp.complete()
            else
              return fallback()
            end
          else
            return fallback()
          end
        end })
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
          symbol_map = { Copilot = "", },
          menu = { Copilot = "Copilot", }
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
    sources = cmp.config.sources(
      { { name = 'git' }, },
      { { name = "path" } },
      { { name = 'buffer' }, },
      { { name = "copilot" } })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    view = { entries = { name = 'column' } },
    formatting = {
      fields = { 'abbr' },
      format = function(_, vim_item)
        return vim_item
      end
    },
    sources = { { name = 'buffer' } }
  })

  cmp.setup.cmdline(':', {
    view = { entries = { name = 'column' } },
    formatting = { fields = { 'abbr' }, },
    sources = cmp.config.sources(
      { { name = 'path' } },
      { { name = 'cmdline' } })
  })
end
