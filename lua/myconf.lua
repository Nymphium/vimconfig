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

-- keymaps {{{
do
  local opts = { noremap = true, silent = true }
  local set_keymap = function(...)
    vim.keymap.set(...)
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
-- }}}

local on_attach = function(client, bufnr)
  illuminate.on_attach(client)

  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.cmd [[setlocal completeopt=menu,menuone,noselect]]
  -- api.nvim_buf_set_option(bufnr, 'completeopt', 'menu,menuone,noselect')

  api.nvim_buf_create_user_command(bufnr, "LspFormat", vim.lsp.buf.formatting, {})
  format.on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

do -- reference / diagnostic {{{
  vim.fn.sign_define('DiagnosticSignError', { text = '🚫', texthl = 'DiagnosticError', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '⚠️', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = '💡', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '👉', texthl = 'DiagnosticHint', linehl = '', numhl = '' })
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

  -- local cb = function(f)
  -- local line = api.nvim_get_current_line()
  -- local path, row, col = line:match('([^|]+)|(%d+)%s+col%s+(%d+)')
  -- row = tonumber(row)
  -- col = tonumber(col)
  -- path = path:gsub('%-', '%%-'):gsub('%.', '%%.')

  -- local win = vim.g.cq_prev_buf

  -- api.nvim_win_set_cursor(win, { row, col })
  -- if type(f) == "function" then
  -- return f(win, row, col)
  -- end
  -- end

  -- local qf = vim.api.nvim_create_augroup(
  -- 'LSPQF',
  -- { clear = true }
  -- )

  -- api.nvim_create_autocmd('FileType', {
  -- group = qf,
  -- pattern = 'qf',
  -- callback = function()
  -- vim.keymap.set('n', '<CR>', function()
  -- return cb(function(win)
  -- api.nvim_set_current_win(win)
  -- end)
  -- end,
  -- { noremap = true, buffer = true })

  -- vim.keymap.set('n', '<CR><CR>', function()
  -- local current_win = api.nvim_get_current_win()
  -- return cb(function(win)
  -- api.nvim_win_close(current_win, true)
  -- api.nvim_set_current_win(win)
  -- end)
  -- end,
  -- { noremap = true, buffer = true })

  -- vim.keymap.set('n', '<ESC><ESC>', function()
  -- local current_win = api.nvim_get_current_win()
  -- return cb(function()
  -- api.nvim_win_close(current_win, true)
  -- end)
  -- end,
  -- { noremap = true, buffer = true })

  -- vim.keymap.set('n', 'j', function()
  -- local current_win = api.nvim_get_current_win()
  -- local lines = vim.fn.line('$')
  -- local pos = api.nvim_win_get_cursor(current_win)
  -- local row = pos[1]
  -- pos[2] = 0

  -- if lines > row then
  -- pos[1] = row + 1
  -- api.nvim_win_set_cursor(current_win, pos)
  -- end

  -- return cb()
  -- end,
  -- { noremap = true, buffer = true })

  -- vim.keymap.set('n', 'k', function()
  -- local current_win = api.nvim_get_current_win()
  -- local lines = vim.fn.line('$')
  -- local pos = api.nvim_win_get_cursor(current_win)
  -- local row = pos[1]
  -- pos[2] = 0
  -- if lines > 1 and row > 1 then
  -- pos[1] = row - 1
  -- api.nvim_win_set_cursor(current_win, pos)
  -- end

  -- cb()
  -- end,
  -- { noremap = true, buffer = true })
  -- end
  -- })
end -- }}}

do
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
    lspconfig[server_name].setup {
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
          config.setup {
            capabilities = capabilities,
            lint = true,
            on_attach = on_attach
          }
        end
      end
    end
  })
end

-- completion {{{
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
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item(select_opts)
      else
        fallback()
      end
    end),
    ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
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
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
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
    { name = "copilot",   keyword_length = 1, group_index = 2 },
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = lspkind.cmp_format({
      symbol_map = {
        Copilot = "",
      },
    }),
  },
}

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  }, {
    { name = "copilot" }
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- }}}
