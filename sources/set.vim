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

set encoding=utf-8
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

set ignorecase
set smartcase
set hlsearch
set incsearch
set hidden

set fdm=marker

if has('nvim')
	" interactive replacement
	set inccommand=split

	set nocompatible
endif

set showmatch
set matchtime=2

set showcmd

set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4

set wrap

set scrolloff=20
set backspace=indent,eol,start
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:%,eol:<
" set listchars=tab:>―,trail:.,extends:>,precedes:<,nbsp:%,eol:◁
set matchpairs& matchpairs+=<:>
set ambiwidth=double
" set formatoptions+=mM
set formatoptions=lmoq
set wildmenu
set number
set relativenumber
set cursorcolumn
set cursorline
" if &term =~ "256color"
	" set t_ut=
" endif
" set t_Co=256
" set t_ZH=[3m
" set t_ZR=[22m
" if has('nvim')
	" set termguicolors
" endif

set lazyredraw
set shell=$SHELL
if !has('nvim')
	set clipboard+=unnamed,autoselect
endif
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

if &filetype == "lua"
	set iskeyword+=:
endif

if has('nvim')
	" Neovim-qt Guifont command
	command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
	let g:nvim_qt_fontsize = 7
	execute("Guifont Meslo LG L:h" . g:nvim_qt_fontsize)

	function! g:FontSizePlus()
		let g:nvim_qt_fontsize = g:nvim_qt_fontsize + 1
		execute("Guifont Meslo LG L:h" . g:nvim_qt_fontsize)
	endfunction

	function! g:FontSizeMinus()
		let g:nvim_qt_fontsize = g:nvim_qt_fontsize - 1
		execute("Guifont Meslo LG L:h" . g:nvim_qt_fontsize)
	endfunction

	augroup NVimTerminal
		autocmd!
		autocmd TermOpen                      *        setlocal nonumber
		\|                                             setlocal norelativenumber
		\|                                             setlocal nocursorcolumn
		\|                                             setlocal nocursorline
		\|                                             startinsert
		autocmd TermClose                     *        setlocal number
		\|                                             setlocal relativenumber
		\|                                             setlocal cursorcolumn
		\|                                             setlocal cursorline
	augroup END

else
	if has('gui_running')
		set guioptions=
		set guifont=Meslo\ LG\ L\ 7
		set antialias=on
		set mouse=c
	endif
endif

