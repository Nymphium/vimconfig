if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin('~/.vim/bundle')
	NeoBundleFetch 'Shougo/neobundle.vim'
	call neobundle#end()
	filetype plugin on
	filetype indent on
endif

"" color
NeoBundle "vim-scripts/rdark"

"" support by language
NeoBundleLazy 'adimit/prolog.vim', { 'autoload' : { 'filetypes' : ['prolog'] }}
NeoBundleLazy 'Shougo/vinarise.vim', {'autoload' : {'filetypes' : ['xxd']}}
NeoBundleLazy 'OCamlPro/ocp-indent', {'autoload' : {'filetypes' : ['ocaml']}}
NeoBundleLazy 'kannokanno/previm', {'autoload' : {'filetypes' : ['markdown']}}
" NeoBundleLazy 'rhysd/unite-ruby-require.vim', {'autoload' : { 'filetypes' : ['ruby'] }}
NeoBundleLazy 'Shirk/vim-gas', {'autoload' : { 'filetypes' : ['asm'] }}

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Townk/vim-autoclose'
" NeoBundle 'kana/vim-smartinput'
" NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'tpope/vim-pathogen'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'nathanaelkane/vim-indent-guides'
if has('lua')
	NeoBundle 'Shougo/neocomplete.vim'
endif
NeoBundle 'Shougo/vimproc.vim', {
\	'build' : {
\		'windows' : 'tools\\update-dll-mingw',
\		'cygwin' : 'make -f make_cygwin.mak',
\		'mac' : 'make -f make_mac.mak',
\		'linux' : 'make -j5',
\		'unix' : 'gmake'}}
NeoBundleLazy 'majutsushi/tagbar', {
\	'autload': {
\		'commands': ['TagbarToggle'],
\	},
\	'build': {
\		'mac': 'brew install ctags'}}

"" ----plugins' settings & keymaps----{
"" vim-surround {
		xmap " <Plug>VSurround"
		xmap ' <Plug>VSurround'
		xmap ( <Plug>VSurround)
		xmap { <Plug>VSurround}
		xmap < <Plug>VSurround>
		xmap [ <Plug>VSurround]
	" endfunction
"" }


"" NERDCommenter {
	"" the number of space adding when commenting
	let NERDSpaceDelims = 1

	nmap <ESC>C <Nop>
	nmap <ESC>C <Plug>NERDCommenterToggle
	vmap <ESC>C <Nop>
	vmap <ESC>C <Plug>NERDCommenterToggle
""}

"" neocomplete {
	" let s:bundle = neobundle#get('neocomplete.vim')
	" function! s:bundle.hooks.on_source(bundle)
		" Disable AutoComplPop.
		let g:acp_enableAtStartup = 0
		"" Use neocomplete.
		let g:neocomplete#enable_at_startup = 1
		"" Use smartcase.
		let g:neocomplete#enable_smart_case = 1
		"" Set minimum syntax keyword length.
		let g:neocomplete#sources#syntax#min_keyword_length = 1
		let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

		"" Define dictionary.
		let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
		\ }

		" Define keyword.
		if !exists('g:neocomplete#keyword_patterns')
			let g:neocomplete#keyword_patterns = {}
		endif
		let g:neocomplete#keyword_patterns['default'] = '\h\w*'

		inoremap <ESC>C <Nop>
		inoremap <expr><ESC>C neocomplete#undo_completion()
		" inoremap <expr><C-l> neocomplete#complete_common_string()

		"" <CR>: close popup and save indent.
		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

		function! s:my_cr_function()
		  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
		endfunction

		"" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
		"" <BS>: close popup and delete backword char.
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><ESC><ESC> neocomplete#close_popup()."\<C-c>"

		"" For cursor moving in insert mode(Not recommended)
		inoremap <expr><ESC>h neocomplete#close_popup() . "\<Left>"
		inoremap <expr><ESC>l neocomplete#close_popup() . "\<Right>"
		inoremap <expr><ESC>k neocomplete#close_popup() . "\<Up>"
		inoremap <expr><ESC>j neocomplete#close_popup() . "\<Down>"

		"" Enable omni completion.
		augroup OmniCompletion
			autocmd!
			autocmd FileType *.css setlocal omnifunc=csscomplete#CompleteCSS
			autocmd FileType *.html,*.markdown setlocal omnifunc=htmlcomplete#CompleteTags
			autocmd FileType *.javascript setlocal omnifunc=javascriptcomplete#CompleteJS
			autocmd FileType *.python setlocal omnifunc=pythoncomplete#Complete
			autocmd FileType *.xml setlocal omnifunc=xmlcomplete#CompleteTags
			autocmd FileType *.ruby setlocal omnifunc=rubycomplete#Complete
		augroup END

		"" Enable heavy omni completion.
		if !exists('g:neocomplete#sources#omni#input_patterns')
		  let g:neocomplete#sources#omni#input_patterns = {}
		endif
		let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
		let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
		let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
	" endfunction
"" }

"" vim-over {
	let g:over_command_line_prompt = "Over > "
	hi OverCommandLineCursor cterm=bold,reverse ctermfg=46
	hi OverCommandLineCursorInsert cterm=bold,reverse ctermfg=46

	nnoremap <silent> %% :OverCommandLine<CR>%s/
	nnoremap <silent> %P y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!','g')<CR>!!gI<Left><Left><Left>
	" nnoremap / <Nop>
	" nnoremap <silent> / :OverCommandLine<CR>/
	" nnoremap n <Nop
	" nnoremap <silent> n :OverCommandLine<CR>/<Up><CR>
"" }

"" vim-quickrun {
	" let s:bundle = neobundle#get('vim-quickrun')
	" function! s:bundle.hooks.on_source(bundle)
		let g:quickrun_config = {}

		let g:quickrun_config['*'] = {
			\ 'outputter/buffer/close_on_empty' : 1 ,
		\ }

		let g:quickrun_config['tex'] = {
			\ 'command' : 'lpshow', 
			\ 'outputter/error/error' : 'quickfix',
		\ }
		let g:quickrun_config['cpp'] = {
			\ 'command' : 'clang++',
			\ 'cmdopt': '-Wall -lm -march=native --std=c++11 -O3'
		\ }
		let g:quickrun_config['c'] = {
			\ 'command' : 'clang',
			\ 'cmdopt' : "-Wall -lm -march=native --std=c11 -O3"
		\ }

		autocmd BufWritePost *.tex silent :QuickRun
	" endfunction
"" }

"" vim-pathogen {
	" let s:bundle = neobundle#get('vim-pathogen')
	" function! s:bundle.hooks.on_source(bundle)
		call pathogen#infect()
	" endfunction
"" }

"" syntastic {
	" let s:bundle = neobundle#get('syntastic')
	" function! s:bundle.hooks.on_source(bundle)
		let g:syntastic_check_on_open = 1
		let g:syntastic_loc_list_height = 3
		let g:syntastic_echo_current_error = 1
		let g:syntastic_enable_balloons = 1
		let g:syntastic_enable_highlighting = 1
		let g:syntastic_enable_signs=1
		let g:syntastic_auto_loc_list=2
		let g:syntastic_ignore_files = ['\.tex$']
		let g:syntastic_cpp_compiler = 'clang++'
		let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall'
		let g:syntastic_c_compiler = 'clang'
		let g:syntastic_c_compiler_options = '-std=c99 -Wall'
		" let g:syntastic_ocaml_use_ocamlc = 1
	" endfunction
"" }

"" vinarise {
	augroup VinariseXXD
		autocmd!
		autocmd BufReadPre *.bin let &binary = 1
		autocmd BufReadPost * if &binary | silent Vinarise
		autocmd BufReadPost * endif
	augroup END
"" }

"" previm {
	let s:bundle = neobundle#get('previm')
	function! s:bundle.hooks.on_source(bundle)
		let g:previm_open_cmd = "firefox --new-window"
	endfunction

	augroup PrevimSettings
		autocmd!
		autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
	augroup END
"" }

"" vim-indent-guides {
	let g:indent_guides_exclude_filetypes=['help', 'man']
	let g:indent_guides_enable_on_vim_startup = 1
"" }

"" vim-gas {
	let s:bundle = neobundle#get('vim-gas')
	function! s:bundle.hooks.on_source(bundle)
		autocmd FileType * if &ft == "asm" | set ft=gas
	endfunction
"" }

"" tagbar {
	" let s:bundle = neobundle#get('tagbar')
	" function! s:bundle.hooks.on_source(bundle)
		nmap <Leader>t :TagbarToggle<CR>
	" endfunction
"" }

"" vim-smartinput-endwise {
	" call smartinput_endwise#define_default_rules()
"" }

"" rdark {
	colorscheme rdark
"" }
