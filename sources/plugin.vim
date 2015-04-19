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
" NeoBundleLazy 'Shougo/vinarise.vim', {'autoload' : {'filetypes' : ['xxd']}}
NeoBundleLazy 'OCamlPro/ocp-indent', {'autoload' : {'filetypes' : ['ocaml']}}
NeoBundleLazy 'kannokanno/previm', {'autoload' : {'filetypes' : ['markdown']}}
" NeoBundleLazy 'rhysd/unite-ruby-require.vim', {'autoload' : { 'filetypes' : ['ruby'] }}
NeoBundleLazy 'Shirk/vim-gas', {'autoload' : { 'filetypes' : ['asm', 'gas'] }}
NeoBundleLazy 'lervag/vimtex', {'autoload' : {'filetypes' : ['tex'] }}
NeoBundleLazy 'leafo/moonscript-vim', {'autoload' : {'filetypes' : ['moon'] }}

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-pathogen'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'scrooloose/syntastic'
" NeoBundle 'nathanaelkane/vim-indent-guides'
if has('lua')
	NeoBundle 'Shougo/neocomplete.vim'
endif
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {
\	'build' : {
\		'windows' : 'tools\\update-dll-mingw',
\		'cygwin' : 'make -f make_cygwin.mak',
\		'mac' : 'make -f make_mac.mak',
\		'linux' : 'make -j5',
\		'unix' : 'gmake'}}
NeoBundleLazy 'tsukkee/unite-tag', {'depends' : 'Shougo/unite.vim'}
NeoBundle 'tpope/vim-fugitive'

"" ----plugins' settings & keymaps----{
"" vim-surround {
		xmap " <Plug>VSurround"
		xmap ' <Plug>VSurround'
		xmap ( <Plug>VSurround)
		xmap { <Plug>VSurround}
		xmap < <Plug>VSurround>
		xmap [ <Plug>VSurround]
"" }


"" NERDCommenter {
	"" the number of space adding when commenting
	let NERDSpaceDelims = 1

	nmap <M-C> <Nop>
	nmap <M-C> <Plug>NERDCommenterToggle
	vmap <M-C> <Nop>
	vmap <M-C> <Plug>NERDCommenterToggle
	nmap <ESC>C <Nop>
	nmap <ESC>C <Plug>NERDCommenterToggle
	vmap <ESC>C <Nop>
	vmap <ESC>C <Plug>NERDCommenterToggle
""}

"" neocomplete {
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

	inoremap <M-c> <Nop>
	inoremap <expr><M-c> neocomplete#undo_completion()
	inoremap <ESC>c <Nop>
	inoremap <expr><ESC>c neocomplete#undo_completion()

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
"" }

"" vim-over {
	let g:over_command_line_prompt = "Over > "
	hi OverCommandLineCursor cterm=bold,reverse ctermfg=46
	hi OverCommandLineCursorInsert cterm=bold,reverse ctermfg=46

	nnoremap <silent> %% :OverCommandLine<CR>%s/
	nnoremap <silent> %P y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!','g')<CR>!!gI<Left><Left><Left>
"" }

"" vim-quickrun {
	let g:quickrun_config = {}

	let g:quickrun_config['*'] = {
		\ 'outputter/buffer/close_on_empty' : 1 ,
	\ }

	" let g:quickrun_config.tex = {
		" \ 'command' : 'latexmk',
		" \ 'exec' : ['%c -halt-on-error | egrep -i "error|can.t use" -A 2'],
		" \ 'outputter/error/error' : 'quickfix',
	" \ }

	let g:quickrun_config.cpp = {
		\ 'command' : 'clang++',
		\ 'cmdopt': '-Wall -lm -march=native --std=c++11 -O3'
	\ }
	let g:quickrun_config.c = {
		\ 'command' : 'clang',
		\ 'cmdopt' : "-Wall -lm -march=native --std=c11 -O3"
	\ }

	let g:quickrun_config.moon = {
		\ 'command' : 'moon'
	\ }
"" }

"" vim-pathogen {
	call pathogen#infect()
"" }

"" matchit {
	augroup Matchit
		autocmd!
		autocmd FileType lua let b:match_words = '\<\(if\|function\|for\|while\)\>:\<\(\|then\|do\)\>:\<\(elseif\)\>:\<\(else\)\>:\<\(end\)\>'
		autocmd FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
		autocmd Filetype tex,vim let b:match_words = '（:）,【:】'
	augroup END
"" }

"" syntastic {
		if &enc == "utf8"
			let g:syntastic_check_on_open = 1
		endif
		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_check_on_wq = 0
		let g:syntastic_loc_list_height = 3
		let g:syntastic_echo_current_error = 1
		let g:syntastic_enable_balloons = 1
		let g:syntastic_enable_highlighting = 1
		let g:syntastic_enable_signs=1
		let g:syntastic_auto_loc_list=2
		let g:syntastic_cpp_compiler = 'clang++'
		let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall'
		let g:syntastic_c_compiler = 'clang'
		let g:syntastic_c_compiler_options = '-std=c99 -Wall'
		let g:syntastic_ignore_files = ['\.tex$']
		let g:syntastic_lua_checkers = ["luac", "luacheck"]
		let g:syntastic_lua_luacheck_args = ["-d", "-a", "-u"]
		let g:syntastic_moon_checkers = ['mooncheck']
		" let g:syntastic_moon_mooncheck_args = ["-d", "-a", "-u"]
		let g:syntastic_sh_checkers = ['shellcheck']
		set statusline+=\ %#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}
		set statusline+=%*
"" }

"" previm {
	let s:bundle = neobundle#get('previm')
	function! s:bundle.hooks.on_source(bundle)
		let g:previm_open_cmd = "open"
		let g:previm_enable_realtime = 1
	endfunction

	augroup PrevimSettings
		autocmd!
		autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
	augroup END
"" }

"" vim-gas {
	augroup VimGas
		autocmd!
		autocmd BufNewFile,BufRead *.{asm,s} set filetype=gas
	augroup END
"" }

"" LaTeX {
	let g:vimtex_view_method = 'general'
	let g:vimtex_view_general_viewer ='evince'
	let g:vimtex_fold_enabled = 0
	let g:vimtex_latexmk_options = '-pdfdvi'

	function! s:findInPdf(...)
		let l:str = ''

		if a:0 < 1
			let l:tmp = @x
			normal "xye
			let l:str = @x . ' '
			let @x = l:tmp
		else
			let l:str = a:1 . ' '
		endif

		if strlen(l:str) > 2
			call system("evince -l ". l:str . g:vimtex#data[b:vimtex.id].out() . " >/dev/null 2>&1 &")
		endif
	endfunction

	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.tex = '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'

	augroup LatexSetup
		autocmd!
		autocmd BufNewFile,BufRead *.tex set ft=tex
		autocmd BufNewFile,Bufread *.tex vmap <silent> <LocalLeader>lf :call <SID>findInPdf(@*)<CR>
		autocmd BufNewFile,Bufread *.tex nmap <silent> <LocalLeader>lf :call <SID>findInPdf()<CR>
	augroup END
"" }

"" rdark {
	colorscheme rdark

	if has('gui_running')
		colorscheme evening
	endif

"" }

"" unite-tag {
	nmap <Leader>t :exec "Unite tag"<CR>
"" }

