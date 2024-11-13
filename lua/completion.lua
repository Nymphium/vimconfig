local luasnip = require 'luasnip'
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local has_words_before = function()
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
