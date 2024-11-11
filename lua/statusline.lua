local mode_current = function()
  return vim.api.nvim_get_mode().mode
end

local compile = function()
  return "%0* B%n W%{win_getid()} L%l C%v "
      .. ("%%2* %s "):format(mode_current())
      .. "%0* "
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  callback = function()
    vim.cmd([=[setlocal statusline=%!v:lua.require'statusline'.compile()]=])
  end
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  callback = function()
    vim.cmd([[setlocal statusline=\ B%n\ W%{win_getid()}\ %t]])
  end
})

return { compile = compile }
