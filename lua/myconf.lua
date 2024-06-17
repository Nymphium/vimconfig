local vim = vim
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
  set_keymap("n", pfx 'k', function() vim.lsp.buf.hover() end, opts)
  set_keymap("n", pfx 'g', function() vim.lsp.buf.definition() end, opts)
  set_keymap("n", pfx 'i', function() vim.lsp.buf.implementation() end, opts)
  set_keymap("n", pfx 'i', function() vim.lsp.buf.implementation() end, opts)

  set_keymap("n", pfx '<F1>', function() vim.lsp.buf.signature_help() end, opts)

  set_keymap("n", pfx 'f', function() vim.lsp.buf.add_workspace_folder() end, opts)
  set_keymap("n", pfx 'fw', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  set_keymap("n", pfx 'fl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  set_keymap("n", pfx 'r', function() vim.lsp.buf.rename() end, opts)
  set_keymap("n", pfx 'a', function() vim.lsp.buf.code_action() end, opts)
  set_keymap('n', pfx 'e', function() vim.diagnostic.open_float() end, opts)
  set_keymap("n", pfx 'b',
    function()
      vim.g.cq_prev_buf = vim.api.nvim_get_current_win();
      vim.lsp.buf.references()
    end, opts)

  set_keymap("n", '<leader><up>', function() vim.diagnostic.goto_prev() end, opts)
  set_keymap("n", '<leader><down>', function() vim.diagnostic.goto_next() end, opts)

  set_keymap("n", pfx 'q',
    function()
      vim.g.cq_prev_buf = vim.api.nvim_get_current_win();
      vim.diagnostic.setloclist()
    end, opts)

  set_keymap("n", pfx '=', function() vim.lsp.buf.format { async = true } end, opts)

  set_keymap("n", pfx 'n', function() require "illuminate".next_reference { wrap = true } end, opts)
  set_keymap("n", pfx 'p', function() require "illuminate".next_reference { reverse = true, wrap = true } end, opts)
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
end -- }}}

do
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  local illuminate = require('illuminate')
  local on_attach = function(client, bufnr)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
    illuminate.on_attach(client)

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = vim.lsp.buf.format
      })
    end
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
  mason_lspconfig.setup()

  local config = {
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
          signs = { min = vim.diagnostic.severity.HINT, },
          virtual_text = { min = vim.diagnostic.severity.WARN, },
        }
      )
    }
  }

  local lualsp_config
  do
    local m = {}
    lualsp_config = setmetatable(m, { __index = config })
    m.setting = {
      Lua = {
        runtime = {
          os.getenv("VIMRUNTIME") .. "/lua"
        }
      }
    }
  end

  local start_server = function(name)
    local server = lspconfig[name]
    ---@diagnostic disable-next-line: redefined-local
    local config = config
    if name == 'lua_lsp' then
      config = lualsp_config
    end

    if server then
      return server.setup(config)
    end
  end

  mason_lspconfig.setup_handlers({ function(server_name)
    return start_server(server_name)
  end })

  api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
      local ft = vim.bo.filetype
      local st = require('lsp_list')[ft]

      if st then
        local name = st[1]
        return start_server(name)
      end
    end
  })
end

do -- completion
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  -- local has_words_before = function()
  -- if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  -- local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  -- end

  cmp.setup {
    experimental = { ghost_text = true },
    snippet = {
      expand = function(args)
        return luasnip.lsp_expand(args.body)
      end
    },
    mapping = {
      ["<Tab>"] = vim.schedule_wrap(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          return luasnip.jump(-1)
        else
          return fallback()
        end
      end),
      ['<C-x>'] = cmp.mapping(function()
        return cmp.complete({
          config = {
            sources = {
              { name = "nvim_lsp", keyword_length = 0 },
              { name = "copilot",  keyword_length = 0 } }
          }
        })
      end),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp',  keyword_length = 2, group_index = 2 },
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
      { name = "copilot",   keyword_length = 0, group_index = 2, },
    },
    window = {
      completion = {
        border = "rounded",
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = { border = "rounded", },
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
    -- formatting = {
    -- fields = { 'abbr' },
    -- format = function(_, vim_item)
    -- return vim_item
    -- end
    -- },
    sources = { { name = 'buffer' } }
  })

  cmp.setup.cmdline(':', {
    view = { entries = { name = 'column' } },
    -- formatting = { fields = { 'abbr' }, },
    sources = cmp.config.sources(
      { { name = 'path' } },
      { { name = 'cmdline' } })
  })

  cmp.setup.filetype('copilot-chat', {
    sources = cmp.config.sources(
      { { name = 'copilot' } },
      { { name = 'buffer' } })
  })
end
