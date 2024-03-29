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
set listchars=tab:>-,trail:.,extends:…,precedes:↵,nbsp:%,eol:↵
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
set updatetime=500
set display=uhex,lastline
set whichwrap=b,s,h,l,<,>,[,]
set pumblend=15
set winblend=15

set splitright

set shellslash

