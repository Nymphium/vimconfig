set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

set nobackup
set noswapfile

set grepprg=grep\ -nH\ $*
set nocompatible
set history=2000

set ignorecase
set smartcase
set hlsearch
set incsearch

set showmatch
set matchtime=2

set showcmd

set shiftwidth=4
set tabstop=4
set autoindent
set wrap

set scrolloff=20
set backspace=indent,eol,start
set list
set listchars=tab:>_,trail:.,extends:>,precedes:<,nbsp:%,eol:<
set matchpairs& matchpairs+=<:>
set ambw=double
set formatoptions+=mM
set wildmenu
set number
set relativenumber
set cursorcolumn
set cursorline
if &term =~ "256color"
	set t_ut=
endif
set t_Co=256
set t_ZH=[3m
set t_ZR=[23m
set lazyredraw
set shell=$SHELL
if !has('nvim')
	set clipboard+=unnamed,autoselect
endif
set timeoutlen=250
set display=uhex,lastline

set omnifunc=syntaxcomplete#Complete

"" StatusLine settings
set statusline=[file:\"%t%m\"\|Type:\"%Y\"\|%{'Enc:\"'.(&fenc!=''?&fenc:&enc).'\"]'}\ %h%w\L%l\/%L\ %v
set laststatus=2

set splitright

set shellslash

set viminfo='100,<1000,s50,h,n~/.viminfo

" set conceallevel=2

if has('gui_running')
	set guioptions=
	set antialias
	set nobackup
	set guifont=Monaco\ 6
	set cmdheight=2
	set antialias=on
	set mouse=c
endif

