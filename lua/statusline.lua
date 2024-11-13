local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local mode_current = function()
  return modes[vim.api.nvim_get_mode().mode]
end

local compile = function()
  return ("%%0* %s "):format("%l:%v")
      .. ("%%#StatusLineMode# %s "):format(mode_current())
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
