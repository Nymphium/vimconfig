local api = vim.api

local pfx = function(c)
  return '<leader>l' .. c
end

local illuminate = require('illuminate')

local on_attach = function(client, bufnr)
  illuminate.on_attach(client)

  local function buf_set_keymap(...)
    api.nvim_buf_set_keymap(bufnr, ...)
  end

  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- keymaps {{{
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", pfx'k', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", pfx'g', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", pfx'i', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

  buf_set_keymap("n", pfx'<F1>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  buf_set_keymap("n", pfx'f', "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", pfx'fw', "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", pfx'fl', "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", pfx'r', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", pfx'a', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", pfx'b', "<cmd>lua vim.g.cq_prev_buf = vim.api.nvim_get_current_win(); vim.lsp.buf.references()<CR>", opts)

  buf_set_keymap("n", pfx'se', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

  buf_set_keymap("n", '<leader><up>', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", '<leader><down>', "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  buf_set_keymap("n", pfx'q', "<cmd>lua vim.g.cq_prev_buf = vim.api.nvim_get_current_win(); vim.diagnostic.setloclist()<CR>", opts)

  buf_set_keymap("n", pfx'=', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  buf_set_keymap("n", pfx'n', [[<cmd>lua require"illuminate".next_reference{wrap=true}<cr>]], opts)
  buf_set_keymap("n", pfx'p', [[<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>]], opts)
  -- }}}
end

local lspconfig = require "lspconfig"
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

do -- reference / diagnostic {{{
  vim.fn.sign_define('DiagnosticSignError', { text = '❌', texthl = 'DiagnosticError', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignWarn', { text = '⚠', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignInfo', { text = '💡', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignHint', { text = '👉', texthl = 'DiagnosticHint', linehl = '', numhl = '' })
  local cb = function(f)
    local line = api.nvim_get_current_line()
    local path, row, col = line:match('([^|]+)|(%d+)%s+col%s+(%d+)')
    row = tonumber(row)
    col = tonumber(col)
    path = path:gsub('%-', '%%-'):gsub('%.', '%%.')

    local win = vim.g.cq_prev_buf

    api.nvim_win_set_cursor(win, {row, col})
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

local lsp_st = {
  lua = {'sumneko_lua'},
  vim = {'vimls'},
  ocaml = {'ocamllsp'},
  typescript = {'tsserver'},
  haskell = {'haskell-language-server'}
}

api.nvim_create_autocmd('FileType', {
  pattern =  '*',
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
local cmp = require'cmp'

local has_words_before = function()
  local line, col = table.unpack(api.nvim_win_get_cursor(0))
  return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    ['<CR>'] = cmp.mapping(function(fallback)
        api.nvim_exec_autocmds('CompleteDone', {})
        return cmp.mapping.confirm({ select = true })(fallback)
      end)
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' }
  }
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
