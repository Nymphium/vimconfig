local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL",
  [""] = "VISUAL",
  ["s"] = "SELECT",
  ["S"] = "SELECT",
  [""] = "SELECT",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
  ["nt"] = "TERMINAL",
}

local mode_color = {
  NORMAL = 'MiniStatuslineModeNormal',
  INSERT = 'MiniStatuslineModeInsert',
  VISUAL = 'MiniStatuslineModeVisual',
  COMMAND = 'MiniStatuslineModeVisual',
  REPLACE = 'MiniStatuslineModeReplace',
}

setmetatable(mode_color, {
  __index = function(self, k)
    local raw = rawget(self, k)
    if raw then
      return raw
    else
      return 'MiniStatuslineModeOther'
    end
  end
})

local mode_current = function()
  local mode = modes[vim.api.nvim_get_mode().mode]
  local color = mode_color[mode]
  return color, mode
end

local compile = function()
  return "%#Normal#"
      .. ("%%#%s# %s %%#Normal#"):format(mode_current())
      .. ("%%m%%h %%#Normal#%s%%#Normal#"):format(require('lspsaga.symbol.winbar').get_bar() or '%t')
end

vim.opt.ruler = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.cmd([=[set statusline=%#NonText#]=])


vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  callback = vim.schedule_wrap(function()
    if vim.fn.winheight(0) > 1 and vim.bo.buftype == '' then
      vim.cmd([=[setlocal winbar=%!v:lua.require'statusline'.compile()]=])
    end
  end)
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = vim.schedule_wrap(function()
    if vim.fn.winheight(0) > 1 and vim.bo.buftype == '' then
      vim.cmd([=[setlocal winbar=%!v:lua.require'statusline'.compile()]=])
    end
  end)
})

vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  callback = vim.schedule_wrap(function()
    if vim.fn.winheight(0) > 1 and vim.bo.buftype ~= 'nofile' then
      vim.cmd([[setlocal winbar=\ %m\ %t]])
    end
  end)
})

return { compile = compile }
