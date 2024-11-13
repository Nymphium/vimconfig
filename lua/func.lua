vim.cmd [[syntax match Shebang /^#!.*$/]]

local detect_from_shebang = function()
  if #vim.bo.filetype > 1 then
    return
  end

  local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  local this_ft = line:match('#!.-/bin/([%w]+)')

  if this_ft and #this_ft > 0 then
    if this_ft == 'bash' or this_ft == 'zsh' then
      this_ft = 'sh'
    end

    vim.bo.filetype = this_ft
  end
end

local augroup = vim.api.nvim_create_augroup('DetectFromShebangAndHighlightAgain', {})
vim.api.nvim_set_hl(0, 'Shebang', { link = 'MiniHipatternsFixme' })

vim.api.nvim_clear_autocmds({ group = augroup })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  callback = detect_from_shebang
})

vim.api.nvim_create_user_command('Dirof',
  function()
    print(vim.fn.expand('%:p:h'))
  end,
  {})
