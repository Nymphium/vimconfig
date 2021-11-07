scriptencoding utf-8

let g:loaded_gzip=1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball=1
let g:loaded_vimballPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHeadlers = 1

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

set fdm=marker

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

"" StatusLine settings
set statusline=[
set statusline+=File:\"%t%m\" " filename[modified?]
set statusline+=\|Type:\"%Y\" " filetype
set statusline+=\|Enc:\"%{(&fenc!=''?&fenc:&enc)}\" " file encoding
set statusline+=]
set statusline+=\ (%h%w\L%l\/%L\ C%v\ W%{win_getid()}\ B%n) " (current linenenumber)/(all linenumber) (nth character) (window id) (buffer number)
set laststatus=2

set splitright

set shellslash

" set viminfo='100,<1000,s50,h,n~/.viminfo

" set conceallevel=2

if &filetype ==# 'lua'
	set iskeyword+=:
endif

" function! g:FontSizePlus()
	" let g:nvim_qt_fontsize = g:nvim_qt_fontsize + 1
	" execute('Guifont Meslo LG L:h' . g:nvim_qt_fontsize)
" endfunction

" function! g:FontSizeMinus()
	" let g:nvim_qt_fontsize = g:nvim_qt_fontsize - 1
	" execute('Guifont Meslo LG L:h' . g:nvim_qt_fontsize)
" endfunction

augroup NVimTerminal
	autocmd!
	autocmd TermOpen  * setlocal nonumber
	\|                  setlocal norelativenumber
	\|                  setlocal nocursorcolumn
	\|                  setlocal nocursorline
	\|                  setlocal statusline=TERMINAL\ (L%l/%L\ C%v\ W%{win_getid()}\ B%n)
	\|                  startinsert
augroup END

