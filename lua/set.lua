vim.o.fileencoding = 'utf-8'
vim.o.fileencodings = 'utf-8,iso-2022-jp,sjis,cp932,euc-jp'
vim.o.fileformats = 'unix,dos,mac'

vim.o.backup = false
vim.o.swapfile = false
vim.o.ttyfast = true
vim.o.autoread = true
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.history = 2000

vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.hidden = true

vim.o.inccommand = 'split'

vim.o.showmatch = true
vim.o.matchtime = 2

vim.o.showcmd = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.wrap = true
vim.o.wildignorecase = true

vim.o.scrolloff = 20
vim.o.backspace = 'indent,eol,start'
vim.o.list = true

vim.opt.listchars = {
  tab = '>-',
  trail = '·',
  extends = '…',
  precedes = '↵',
  nbsp = '␣',
  eol = '↵'
}

vim.o.matchpairs = vim.o.matchpairs .. ',<:>'

vim.o.formatoptions = 'lmoq'
vim.o.wildmenu = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorcolumn = true
vim.o.cursorline = true

vim.o.lazyredraw = true
vim.o.timeoutlen = 250
vim.o.updatetime = 500
vim.o.display = 'uhex,lastline'
vim.o.whichwrap = 'b,s,h,l,<,>,[,]'
vim.o.pumblend = 15
vim.o.winblend = 15

vim.o.splitright = true

vim.o.jumpoptions = "stack"

vim.o.laststatus = 3
