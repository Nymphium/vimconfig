local lspconfig = require('lspconfig')

local modes = {
  ['n'] = 'NORMAL',
  ['no'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['V'] = 'VISUAL',
  [''] = 'VISUAL',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT',
  [''] = 'SELECT',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rv'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MOAR',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
  ['nt'] = 'TERMINAL',
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

local winbar = function()
  local lhs = ''

  local filepath = vim.api.nvim_buf_get_name(0)

  if #filepath > 0 and vim.fn.isdirectory(filepath) == 0 then
    local root
    local dir = lspconfig.util.root_pattern('.git')(filepath)

    if dir then
      root = vim.fn.fnamemodify(dir, ':t')
      dir = vim.fn.fnamemodify(filepath, ':.' .. dir)
    else
      dir = filepath
    end

    if root then
      if root == vim.fs.basename(dir) then
        dir = '/'
      end

      lhs = ('%s%s%s /%s%s'):format('%#MiniFilesTitle#', root, '%#StatusLine#', dir, '%#Normal#')
    else
      lhs = ('%s %s%s'):format('%#StatusLine#', dir, '%#Normal#')
    end
  end

  return '%#Normal#'
      .. ('%%#%s# %s %%#Normal#'):format(mode_current())
      .. ('%%m%%h %%#Normal#%s%%#Normal#'):format(lhs)
      .. '%=' .. (require('lspsaga.symbol.winbar').get_bar() or '')
end

vim.opt.ruler = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.statusline = [[%#NonText#]]

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'FileType' }, {
  callback = vim.schedule_wrap(function()
    if vim.fn.winheight(0) > 1 and vim.bo.buftype == '' then
      vim.opt_local.winbar = [=[%!v:lua.require'statusline'.winbar()]=]
    end
  end)
})

vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  callback = (function()
    if vim.fn.winheight(0) > 1 and vim.bo.buftype == '' then
      vim.opt_local.winbar = [=[ %m %t]=]
    end
  end)
})

local tabline = function()
  local s = ''
  local tabs = vim.fn.tabpagenr('$')

  for i = 1, tabs do
    if i == vim.fn.tabpagenr() then
      s = s .. ('%s[%i]'):format('%#MiniTablineCurrent#', i)
    else
      s = s .. ('%s %i '):format('%#MiniTablineFill#', i)
    end
    s = s .. '%T'
  end
  s = s .. '%#TabLineFill#%#Normal#'
  return s
end

vim.o.tabline = [=[%!v:lua.require'statusline'.tabline()]=]

return { winbar = winbar, tabline = tabline }
