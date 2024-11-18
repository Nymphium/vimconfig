local pfx = function(c)
  return '<leader>l' .. c
end

require('luasnip.loaders.from_vscode').lazy_load()

do -- keymaps
  local opts = { noremap = true, silent = true }
  local set_keymap = function(...)
    return vim.keymap.set(...)
  end
  set_keymap("n", pfx 'k', '<cmd>Lspsaga hover_doc<CR>', opts)
  set_keymap("n", pfx 'g', '<cmd>Lspsaga goto_definition<CR>', opts)
  set_keymap("n", pfx 'G', '<cmd>Lspsaga peek_definition<CR>', opts)
  set_keymap("n", pfx 'i', '<cmd>Lspsaga finder imp<CR>', opts)

  set_keymap("n", pfx '<F1>', function() vim.lsp.buf.signature_help() end, opts)

  set_keymap("n", pfx 'f', function() vim.lsp.buf.add_workspace_folder() end, opts)
  set_keymap("n", pfx 'F', '<cmd>Lspsaga outline<CR>', opts)
  set_keymap("n", pfx 'fw', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  set_keymap("n", pfx 'fl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  set_keymap("n", pfx 'r', '<cmd>Lspsaga rename<CR>', opts)
  set_keymap("n", pfx 'a', '<cmd>Lspsaga code_action<CR>', opts)
  set_keymap('n', pfx 'e', function() vim.diagnostic.open_float() end, opts)
  set_keymap("n", pfx 'b', '<cmd>Lspsaga finder ref<CR>', opts)

  set_keymap("n", '<leader><up>', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  set_keymap("n", '<leader><down>', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

  set_keymap("n", pfx 'q', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)

  set_keymap("n", pfx '=', function() vim.lsp.buf.format { async = true } end, opts)

  set_keymap("n", pfx 'n', function() require "illuminate".next_reference { wrap = true } end, opts)
  set_keymap("n", pfx 'p', function() require "illuminate".next_reference { reverse = true, wrap = true } end, opts)

  vim.api.nvim_create_autocmd({ 'WinLeave' }, {
    callback = function()
      if vim.bo.filetype == 'markdown' and vim.bo.buftype == 'nofile' then
        vim.api.nvim_win_close(0, false)
      end
    end
  })
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

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local illuminate = require('illuminate')
local on_attach = function(client, bufnr)
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end
    })
  end

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
    client.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'rounded' }
    )
  end

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
    client.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded' }
    )
  end

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_publishDiagnostics) then
    client.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        signs = { min = vim.diagnostic.severity.HINT, },
        virtual_text = { min = vim.diagnostic.severity.WARN, },
      }
    )
  end

  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(true, { bufnr })
  end

  illuminate.on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('neoconf').setup({
  local_settings = ',neoconf.json'
})

local lspconfig = require "lspconfig"
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  lint = true,
  showMessage = { messageActionItem = { additionalPropertiesSupport = true } },
})

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

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup()

-- @param server_cmd mason naming convention
local setup_server = function(server_name_lspconfig)
  local server = lspconfig[server_name_lspconfig]

  if server
      and (
        (not server.manager)
        or #server.manager._clients == 0)
  then
    local default_config = server.default_config or server.config_def.default_config
    if default_config
        and default_config.cmd
        and #default_config.cmd > 0 and
        vim.fn.executable(default_config.cmd[1]) == 1 then
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

      server.setup({
        on_attach = on_attach,
      })
    end
  end
end

mason_lspconfig.setup_handlers({ setup_server })

vim.api.nvim_create_autocmd({ 'FileType' }, {
  once = true,
  callback = function(args)
    for _, v in ipairs(mason_lspconfig.get_available_servers(args.filetype)) do
      setup_server(v)
    end
  end
})
