local pfx = function(c)
  return '<leader>l' .. c
end

local navbuddy = require('nvim-navbuddy')

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
  set_keymap("n", pfx 'r', vim.lsp.buf.rename, opts)
  set_keymap("n", pfx 'a', '<cmd>Lspsaga code_action<CR>', opts)
  set_keymap('n', pfx 'e', function() vim.diagnostic.open_float() end, opts)
  set_keymap("n", pfx 'b', '<cmd>Lspsaga finder ref<CR>', opts)

  set_keymap('n', pfx 't', function() navbuddy.open() end, opts)

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

local on_attach = function(client, bufnr)
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_hover) then
    client.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = 'rounded' })
  end

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
    client.handlers['textDocument/signatureHelp'] = vim.lsp.buf.signature_help(
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

  if client.supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
    navbuddy.attach(client, bufnr)
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  callback = function()
    vim.lsp.codelens.refresh({ bufnr = 0 })
  end
})

local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require "lspconfig"
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  lint = true,
  showMessage = { messageActionItem = { additionalPropertiesSupport = true } },
  capabilities = capabilities,
  autostart = true,
  on_attach = on_attach
})

vim.lsp.config('clangd', {
  filetypes = { "c", "cpp", "objc", "objcpp" }
})

vim.lsp.config('lua_ls', {
  on_attach = on_attach
})

require('mason').setup({
  PATH = 'append',
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require('mason-lspconfig').setup {
  ensure_installed = { 'lua_ls' },
  automatic_enable = true,
}

require('lspsaga').setup({
  rename = {
    keys = {
      quit = '<ESC>',
    }
  },
  hover = {
    open_cmd = '!firefox',
  },
  lightbulb = {
    enable = false
  },
  code_action = {
    extend_gitsigns = true,
  },
  outline = {
    win_position = 'left',
  },
  symbol_in_winbar = {
    enable = false,
    -- color_mode = false,
    folder_level = 0,
    show_file = false,
    separator = ' '
  }
})


local disabled_lsp = {
  'lua_ls', -- start by lazydev
  'clangd',
  'rubocop'
}

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'BufWinEnter' }, {
  callback = function()
    local ft = vim.bo.filetype
    if ft == '' then return end

    local cls = vim.lsp.get_clients({ bufnr = 0 })
    local attached_clients = {}
    for _, k in ipairs(cls) do
      attached_clients[k.name] = true
    end

    local lsps = require('mason-lspconfig').get_available_servers({ filetype = ft })
    for _, k in pairs(lsps) do
      if disabled_lsp[k] or attached_clients[k] then
        lsps[k] = nil
      end
    end

    if #lsps == 0 then return end

    -- ignore executable not found
    pcall(vim.lsp.enable, lsps)
  end
})
