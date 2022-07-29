scriptencoding utf-8

set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

set nobackup
set noswapfile
set ttyfast
set autoread

set grepprg=ag\ --vimgrep\ --hidden\ -S\ --stats\ $*
set grepformat=%f:%l:%c:%m
set history=2000

" set ignorecase
set smartcase
set hlsearch
set incsearch
set hidden

  " interactive replacement
set inccommand=split

set showmatch
set matchtime=2

set showcmd

set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set shiftwidth=2
set expandtab

set wrap
set wildignorecase

set scrolloff=20
set backspace=indent,eol,start
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:%,eol:<
" set listchars=tab:>―,trail:.,extends:>,precedes:<,nbsp:%,eol:◁
set matchpairs& matchpairs+=<:>
" set ambiwidth=double
" set formatoptions+=mM
set formatoptions=lmoq
set wildmenu
set number
set relativenumber
set cursorcolumn
set cursorline

set lazyredraw
set shell=$SHELL
set clipboard+=unnamed
set timeoutlen=250
set display=uhex,lastline
set whichwrap=b,s,h,l,<,>,[,]

set splitright

set shellslash

" set viminfo='100,<1000,s50,h,n~/.viminfo

" set conceallevel=2

if &filetype ==# 'lua'
  set iskeyword+=:
endif

augroup NVimTerminal
  autocmd!
  autocmd TermOpen  * setlocal nonumber
  \|                  setlocal norelativenumber
  \|                  setlocal nocursorcolumn
  \|                  setlocal nocursorline
  \|                  setlocal statusline=TERMINAL\ (L%l/%L\ C%v\ W%{win_getid()}\ B%n)
  \|                  startinsert
augroup END

