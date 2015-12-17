"" set nocompatible

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"" plugins {{{
	"" colorscheme
	NeoBundle 'vim-scripts/rdark'

	"" support by language
	NeoBundleLazy 'OCamlPro/ocp-indent', {'autoload' : {'filetypes' : ['ocaml']}}
	NeoBundleLazy 'Shirk/vim-gas', {'autoload' : { 'filetypes' : ['asm', 'gas'] }}
	NeoBundleLazy 'lervag/vimtex', {'autoload' : {'filetypes' : ['tex'] }}
	NeoBundleLazy 'leafo/moonscript-vim', {'autoload' : {'filetypes' : ['moon'] }}
	NeoBundleLazy 'nymphium/syntastic-moonscript', {
	\    'build' : {'linux' : 'make neobundle'},
	\    'autoload' : {'filetypes' : ['moon']},
	\    'depends' : ['scrooloose/syntastic']}
	NeoBundleLazy 'vim-scripts/javacomplete', {
	\   'build': {'linux': 'javac autoload/Reflection.java'}}

	NeoBundleLazy 'wesleyche/SrcExpl', {'autoload' : {'commands': ['SrcExplToggle']}}
	NeoBundle 'thinca/vim-quickrun'
	NeoBundle 'osyo-manga/vim-over'
	NeoBundle 'scrooloose/nerdcommenter'
	NeoBundle 'tpope/vim-surround'
	NeoBundle 'tpope/vim-endwise'
	NeoBundle 'Townk/vim-autoclose'
	NeoBundle 'tmhedberg/matchit'
	NeoBundle 'scrooloose/syntastic'
	if has('nvim')
		NeoBundle "Shougo/deoplete.nvim"
	elseif has('lua')
		NeoBundle 'Shougo/neocomplete.vim'
		"" NeoBundle 'Shougo/neosnippet'
		"" NeoBundle 'Shougo/neosnippet-snippets'
	endif
	NeoBundle 'Shougo/unite.vim'
	NeoBundle 'Shougo/vimproc.vim', {
	\ 'build' : {
	\     'windows' : 'tools\\update-dll-mingw',
	\     'cygwin' : 'make -f make_cygwin.mak',
	\     'mac' : 'make -f make_mac.mak',
	\     'linux' : 'make',
	\     'unix' : 'gmake',
	\    },
	\ }
	NeoBundle 'tsukkee/unite-tag'
	NeoBundle 'tpope/vim-fugitive'
"" }}}

call neobundle#end()
NeoBundleCheck


"" ----plugins' settings & keymaps----{{{
"" vim-surround {{{
	if !empty(neobundle#get('vim-surround'))
		xmap " <Plug>VSurround"
		xmap ' <Plug>VSurround'
		xmap ( <Plug>VSurround)
		xmap { <Plug>VSurround}
		xmap < <Plug>VSurround>
		xmap [ <Plug>VSurround]
	endif
"" }}}

"" NERDCommenter {{{
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
""}}}

"" deoplete {{{
	let g:deoplete#enable_at_startup = 1

	if !empty(neobundle#get('deoplete.nvim'))
		let g:deoplete#enable_smart_case = 1
		let g:deoplete#auto_completion_start_length=1
		let g:deoplete#sources = {}
		let g:deoplete#sources._ = ['buffer', 'tag']
		if !exists('g:deoplete#keyword_patterns')
			let g:deoplete#keyword_patterns = {}
		endif
		let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\w*'
		" let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
		let g:deoplete#keyword_patterns.tex = ['\\?[a-zA-Z_]\w*', g:deoplete#keyword_patterns._]

		if !exists('g:deopletes#omni#input_patterns')
			let g:deopletes#omni#input_patterns = {}
		endif
		let g:deopletes#omni#input_patterns.tex = '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'

		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<Tab>"
		inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
		inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
		inoremap <expr><C-c> deoplete#mappings#cancel_popup()

		function! s:my_cr_function()
			return pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
		endfunction

		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	endif
"" }}}

"" neocomplete {{{
	"" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1

	if !empty(neobundle#get('neocomplete.vim'))
		"" Disable AutoComplPop.
		let g:acp_enableAtStartup = 0
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

		"" Define keyword.
		if !exists('g:neocomplete#keyword_patterns')
			let g:neocomplete#keyword_patterns = {}
		endif
		let g:neocomplete#keyword_patterns['default'] = '\h\w*'

		"" Enable heavy omni completion.
		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif
		let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'

		inoremap <M-c> <Nop>
		inoremap <expr><M-c> neocomplete#undo_completion()
		inoremap <ESC>c <Nop>
		inoremap <expr><ESC>c neocomplete#undo_completion()

		"" <CR>: close popup and save indent.
		function! s:my_cr_function()
			return pumvisible() ? neocomplete#close_popup() : "\<CR>"
		endfunction

		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

		"" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
		"" <BS>: close popup and delete backword char.
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

		"" Enable omni completion.
		" augroup OmniCompletion
			" autocmd!
			" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
			" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
			" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
			" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
			" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
			" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
		" augroup END
	endif
"" }}}

"" vim-over {{{
	let g:over_command_line_prompt = "Over > "
	hi OverCommandLineCursor cterm=bold,reverse ctermfg=46
	hi OverCommandLineCursorInsert cterm=bold,reverse ctermfg=46

	nnoremap <silent> %% :OverCommandLine<CR>%s/
	nnoremap <silent> %P y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!','g')<CR>!!gI<Left><Left><Left>
"" }}}

"" vim-quickrun {{{
	let g:quickrun_config = {}

	let g:quickrun_config['*'] = {
				\ 'outputter/buffer/close_on_empty' : 1 ,
				\ }

	"" let g:quickrun_config.tex = {
	"" \ 'command' : 'latexmk',
	"" \ 'exec' : ['%c -halt-on-error | egrep -i "error|can.t use" -A 2'],
	"" \ 'outputter/error/error' : 'quickfix',
	"" \ }

	let g:quickrun_config.cpp = {
				\ 'command' : 'g++',
				\ }
	let g:quickrun_config.c = {
				\ 'command' : 'gcc',
				\ }

	let g:quickrun_config.moon = {
				\ 'command' : 'moon'
				\ }
"" }}}

"" matchit {{{
	augroup Matchit
		autocmd!
		autocmd FileType lua let b:match_words = '\<\(if\|function\|for\|while\)\>:\<\(\|then\|do\)\>:\<\(elseif\)\>:\<\(else\)\>:\<\(end\)\>'
		autocmd FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
		autocmd Filetype tex,vim let b:match_words = '（:）,【:】'
	augroup END
"" }}}
"" 
"" syntastic {{{
	if &enc == "utf8"
		let g:syntastic_check_on_open = 1
	endif

	if !empty(neobundle#get("syntastic"))
		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_check_on_wq = 0
		let g:syntastic_loc_list_height = 3
		let g:syntastic_echo_current_error = 1
		let g:syntastic_enable_balloons = 1
		let g:syntastic_enable_highlighting = 1
		let g:syntastic_enable_signs=1
		let g:syntastic_auto_loc_list=2
		let g:syntastic_cpp_compiler = 'g++'
		let g:syntastic_cpp_compiler_options = '-Wall -Wextra'
		let g:syntastic_c_compiler = 'gcc'
		let g:syntastic_c_compiler_options = '-Wall -Wextra'
		let g:syntastic_ignore_files = ['\.tex$']
		let g:syntastic_lua_checkers = ["luac", "luacheck"]
		let g:syntastic_lua_luacheck_args = ["-g", "-d", "-a", "-u", "-r"]
		let g:syntastic_moon_checkers = ['mooncheck', 'moonc']
		let g:syntastic_moon_mooncheck_args = ["-g", "-d", "-a", "-u", "-r"]
		let g:syntastic_sh_checkers = ['shellcheck']
		let g:syntastic_sh_shellcheck_args = ['--exclude=SC2148']
		set statusline+=\ %#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}
		set statusline+=%*
	endif
"" }}}

"" neosnippet {{{
	"" imap <ESC>s <Plug>(neosnippet_expand_or_jump)
	"" imap <M-s> <Plug>(neosnippet_expand_or_jump)
	"" smap <ESC>s <Plug>(neosnippet_expand_or_jump)
	"" smap <M-s> <Plug>(neosnippet_expand_or_jump)
"" }}}

"" SrcExpl {{{
	"" Set refresh time in ms
	let g:SrcExpl_RefreshTime = 1000
	"" Is update tags when SrcExpl is opened
	let g:SrcExpl_isUpdateTags = 0
	"" Tag update command
	" let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase ' . expand("%:p")
	"" Source Explorer Window Height
	let g:SrcExpl_winHeight = 24

	nmap <silent> <LocalLeader>t :SrcExplToggle<CR>
	nmap <silent> <LocalLeader>n :call g:SrcExpl_NextDef()<CR>
	nmap <silent> <LocalLeader>p :call g:SrcExpl_PrevDef()<CR>
"" }}}

"" previm {{{
	if !empty(neobundle#get("previm"))
		let s:bundle = neobundle#get('previm')
		function! s:bundle.hooks.onsource(bundle)
			let g:previm_open_cmd = "open"
			let g:previm_enable_realtime = 1
		endfunction

		augroup PrevimSettings
			autocmd!
			autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
		augroup END
	endif
"" }}}

"" javacomplete {{{
	if !empty(neobundle#get('javacomplete'))
		augroup Javacomplete
			autocmd!
			autocmd FileType java :setlocal omnifunc=javacomplete#Complete
			autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo
		augroup END
	endif
"" }}}

"" vim-gas {{{
  augroup VimGas
  	autocmd!
  	autocmd BufNewFile,BufRead *.{asm,s} set filetype=gas
  augroup END
"" }}}

"" vimtex {{{
	if !empty(neobundle#get('vimtex'))
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
				call system("evince -l ". l:str . g:vimtex_data[0].tex . " >/dev/null 2>&1 &")
			endif
		endfunction

		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif
		let g:neocomplete#sources#omni#input_patterns.tex = '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'


		augroup LatexSetup
			autocmd!
			autocmd BufNewFile,BufRead *.tex set ft=tex
			autocmd BufNewFile,BufRead *.tex vmap <silent> <LocalLeader>lf :call <SID>findInPdf(@*)<CR>
			autocmd BufNewFile,BufRead *.tex nmap <silent> <LocalLeader>lf :call <SID>findInPdf()<CR>
		augroup END
	endif
"" }}}

"" rdark {{{

	if has('gui_running')
		colorscheme evening
	else
		colorscheme rdark
	endif

"" }}}
"" }}}

