---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup({
  day_brightness = 0.4,
  dim_inactive = true,
  on_highlights = function(hl)
    hl.User1 = hl.MiniStatuslineFilename
    hl.User2 = hl.MiniStatuslineDevinfo
    hl.StatusLineMode = hl.MiniStatuslineModeNormal
  end
})

vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLineMode', { link = 'MiniStatuslineModeInsert' })
  end
})

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  pattern = { "*:[vV\x16]" },
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLineMode', { link = 'MiniStatuslineModeVisual' })
  end
})

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  pattern = { "*:c" },
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLineMode', { link = 'MiniStatuslineModeCommand' })
  end
})

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  pattern = { "*:r" },
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLineMode', { link = 'MiniStatuslineModeReplace' })
  end
})

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  pattern = { "*:n" },
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLineMode', { link = 'MiniStatuslineModeNormal' })
  end
})

vim.cmd [[:color tokyonight]]
