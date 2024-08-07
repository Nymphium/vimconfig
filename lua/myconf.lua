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

  set_keymap("n", pfx 'q', ':LspDiagnostics 0<CR>', opts)

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

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end
      })
    end

    vim.lsp.inlay_hint.enable(true, { bufnr })

    illuminate.on_attach(client)
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
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
  lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    lint = true,
    capabilities = capabilities,
    showMessage = { messageActionItem = { additionalPropertiesSupport = true } },
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
  })

  local mason_lspconfig = require('mason-lspconfig')
  mason_lspconfig.setup()

  local lsp_settings = require('lsp_list')
  local setup_server = function(server_name)
    local server = lspconfig[server_name]
    local settings = lsp_settings[server_name]

    if server then
      return server.setup({
        on_attach = on_attach,
        settings = settings
      })
    end
  end

  mason_lspconfig.setup_handlers({ function(server_name)
    return setup_server(server_name)
  end })

  local servers = mason_lspconfig.get_available_servers()
  for _, server_name in pairs(servers) do
    if vim.fn.executable(server_name) == 1 then
      setup_server(server_name)
    end
  end
end

do -- completion
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  cmp.setup {
    experimental = { ghost_text = true },
    snippet = {
      expand = function(args)
        return luasnip.lsp_expand(args.body)
      end
    },
    mapping = cmp.mapping.preset.insert {
      ['<Tab>'] = function(fallback)
        if not cmp.select_next_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,

      ['<S-Tab>'] = function(fallback)
        if not cmp.select_prev_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
      ['<C-x>'] = cmp.mapping.complete(),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources(
      { { name = 'nvim_lsp', keyword_length = 2, group_index = 1 } },
      { { name = 'nvim_lsp_signature_help', group_index = 1 } },
      { { name = "copilot", keyword_length = 0, group_index = 2, } },
      { { name = 'buffer',
        keyword_length = 2,
        group_index = 2,
        options = {
          keyword_pattern = [[\k\+]]
        }
      } },
      { { name = 'luasnip', keyword_length = 2 } },
      { { name = 'path', group_index = 2 } },
      { { name = 'treesitter' } },
      { { name = 'git' } }),
    view = { docs = { auto_open = true } },
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
    mapping  = cmp.mapping.preset.cmdline(),
    view     = { entries = 'column' },
    -- formatting = {
    -- fields = { 'abbr' },
    -- format = function(_, vim_item)
    -- return vim_item
    -- end
    -- },
    sources  = cmp.config.sources(
      { { name = 'nvim_lsp_document_symbol', pattern = '@' } },
      { { name = 'buffer', keyword_length = 1 } }),
    ---@diagnostic disable-next-line: missing-fields
    matching = { disallow_partial_fuzzy_matching = false, },
  })

  cmp.setup.cmdline(':', {
    mapping  = cmp.mapping.preset.cmdline(),
    view     = { entries = 'column' },
    -- formatting = { fields = { 'abbr' }, },
    sources  = cmp.config.sources(
      { { name = 'path' } },
      { { name = 'cmdline' } }),
    ---@diagnostic disable-next-line: missing-fields
    matching = {
      disallow_symbol_nonprefix_matching = false,
      disallow_partial_fuzzy_matching = false,
    },
  })

  cmp.setup.filetype('copilot-chat', {
    sources = cmp.config.sources(
      { { name = 'copilot' } },
      { { name = 'buffer' } })
  })
end
