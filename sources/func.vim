scriptencoding utf-8

syntax match Shebang /^#!.*$/

"" set-shellscript filetype {{{
lua <<EOL
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
vim.cmd[[hi def link Shebang MiniHipatternsFixme]]

if #vim.bo.filetype < 1 then
  vim.api.nvim_clear_autocmds({group = augroup, buffer = vim.fn.bufnr('%')})
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = augroup,
    buffer = vim.fn.bufnr('%'),
    callback = function()
      detect_from_shebang()
    end
  })
end
EOL
"" }}}

function! Dirof()
  return expand('%:p:h')
endfunction

command! Dirof echo Dirof()
