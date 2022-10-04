local vim = vim
local unpack = table.unpack or unpack
local api = vim.api

local pfx = function(c)
  return '<leader>l' .. c
end

local illuminate = require('illuminate')
local format = require 'lsp-format'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()

local on_attach = function(client, bufnr)
  illuminate.on_attach(client)

  local function buf_set_keymap(...)
    api.nvim_buf_set_keymap(bufnr, ...)
  end

  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.cmd [[setlocal completeopt=menu,menuone,noselect]]
  -- api.nvim_buf_set_option(bufnr, 'completeopt', 'menu,menuone,noselect')

  -- keymaps {{{
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", pfx 'k', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", pfx 'g', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", pfx 'i', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

  buf_set_keymap("n", pfx '<F1>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  buf_set_keymap("n", pfx 'f', "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", pfx 'fw', "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", pfx 'fl', "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", pfx 'r', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", pfx 'a', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", pfx 'b',
    "<cmd>lua vim.g.cq_prev_buf = vim.api.nvim_get_current_win(); vim.lsp.buf.references()<CR>", opts)

  buf_set_keymap("n", pfx 'se', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

  buf_set_keymap("n", '<leader><up>', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", '<leader><down>', "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  buf_set_keymap("n", pfx 'q',
    "<cmd>lua vim.g.cq_prev_buf = vim.api.nvim_get_current_win(); vim.diagnostic.setloclist()<CR>", opts)

  buf_set_keymap("n", pfx '=', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  buf_set_keymap("n", pfx 'n', [[<cmd>lua require"illuminate".next_reference{wrap=true}<cr>]], opts)
  buf_set_keymap("n", pfx 'p', [[<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>]], opts)

  api.nvim_buf_create_user_command(bufnr, "LspFormat", vim.lsp.buf.formatting, {})
  format.on_attach(client)
  -- }}}
end

local lspconfig = require "lspconfig"
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

do -- reference / diagnostic {{{
  vim.fn.sign_define('DiagnosticSignError', { text = '❌', texthl = 'DiagnosticError', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '⚠', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })
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

  local cb = function(f)
    local line = api.nvim_get_current_line()
    local path, row, col = line:match('([^|]+)|(%d+)%s+col%s+(%d+)')
    row = tonumber(row)
    col = tonumber(col)
    path = path:gsub('%-', '%%-'):gsub('%.', '%%.')

    local win = vim.g.cq_prev_buf

    api.nvim_win_set_cursor(win, { row, col })
    if type(f) == "function" then
      return f(win, row, col)
    end
  end

  api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
      vim.keymap.set('n', '<CR>', function()
        return cb(function(win)
          api.nvim_set_current_win(win)
        end)
      end,
        { noremap = true, buffer = true })

      vim.keymap.set('n', '<CR><CR>', function()
        local current_win = api.nvim_get_current_win()
        return cb(function(win)
          api.nvim_win_close(current_win, true)
          api.nvim_set_current_win(win)
        end)
      end,
        { noremap = true, buffer = true })

      vim.keymap.set('n', '<ESC><ESC>', function()
        local current_win = api.nvim_get_current_win()
        return cb(function()
          api.nvim_win_close(current_win, true)
        end)
      end,
        { noremap = true, buffer = true })

      vim.keymap.set('n', 'j', function()
        local current_win = api.nvim_get_current_win()
        local lines = vim.fn.line('$')
        local pos = api.nvim_win_get_cursor(current_win)
        local row = pos[1]
        pos[2] = 0

        if lines > row then
          pos[1] = row + 1
          api.nvim_win_set_cursor(current_win, pos)
        end

        return cb()
      end,
        { noremap = true, buffer = true })

      vim.keymap.set('n', 'k', function()
        local current_win = api.nvim_get_current_win()
        local lines = vim.fn.line('$')
        local pos = api.nvim_win_get_cursor(current_win)
        local row = pos[1]
        pos[2] = 0
        if lines > 1 and row > 1 then
          pos[1] = row - 1
          api.nvim_win_set_cursor(current_win, pos)
        end

        cb()
      end,
        { noremap = true, buffer = true })
    end
  })
end -- }}}

local lsp_st = require('lsp_list')

api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ft = vim.bo.filetype
    local st = lsp_st[ft]

    if st and not st.loaded then
      st.loaded = true

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

-- completion {{{
local cmp = require 'cmp'

local has_words_before = function()
  local line, col = unpack(api.nvim_win_get_cursor(0))
  return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup {

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif has_words_before() then
        cmp.complete()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
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
    ['<CR>'] = cmp.mapping.confirm({ select = false })
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp', keyword_length = 2 },
    { name = 'buffer', keyword_length = 2,
      opts = {
        keyword_pattern = [[\k\+]]
      }
    },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'path' }
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}

cmp.setup.cmdline('/', {
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
