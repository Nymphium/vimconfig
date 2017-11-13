if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

"" plugins {{{
	call neobundle#begin(expand('~/.vim/bundle/'))
	NeoBundleFetch 'Shougo/neobundle.vim'

	"" colorscheme {{{
	NeoBundle 'vim-scripts/rdark'
	"" }}}

	"" support by language {{{
	" NeoBundleLazy 'OCamlPro/ocp-indent', {'autoload' : {'filetypes' : ['ocaml']}}
	" NeoBundleLazy 'Shirk/vim-gas', {'autoload' : { 'filetypes' : ['asm', 'gas'] }}
	NeoBundleLazy 'lervag/vimtex', {'autoload' : {'filetypes' : ['tex'] }}
	NeoBundleLazy 'leafo/moonscript-vim', {'autoload' : {'filetypes' : ['moon', 'moonscript'] }}
	NeoBundleLazy 'nymphium/syntastic-moonscript', {
	\    'build' : {'linux' : 'make neobundle VIM=nvim'},
	\    'autoload' : {'filetypes' : ['moon']},
	\    'depends' : ['scrooloose/syntastic']
	\    }
	" NeoBundleLazy 'artur-shaik/vim-javacomplete2', {'autoload' : {'filetypes' : ['java']}}
	NeoBundleLazy 'raymond-w-ko/vim-lua-indent', {'autoload' : {'filetypes' : ['lua']}}
	NeoBundleLazy 'wesleyche/SrcExpl', {'autoload' : {'commands': ['SrcExplToggle']}}
	NeoBundleLazy 'rhysd/nyaovim-markdown-preview', {'autoload' : {'filetypes' : ['md', 'markdown', 'mkd']}}
	NeoBundleLazy 'wlangstroth/vim-racket', {'autoload' : {'filetypes' : ['racket']}}
	NeoBundleLazy 'kovisoft/slimv', {'autoload' : {'filetypes' : ['racket']}}
	" NeoBundleLazy 'rust-lang/rust.vim', {'autoload' : {'filetypes': ['rust']}}
	" NeoBundleLazy 'phildawes/racer', {
	" \   'build' : {
	" \     'mac'  : 'cargo build --release',
	" \     'unix' : 'cargo build --release',
	" \   },
	" \   'autoload' : {
	" \     'filetypes' : 'rust',
	" \   },
	" \ }
	NeoBundleLazy 'dag/vim2hs', {'autoload' : {'filetypes' : ['haskell']}}
	NeoBundleLazy 'kana/vim-filetype-haskell', {'autoload' : {'filetypes' : ['haskell']}}
	NeoBundleLazy 'eagletmt/ghcmod-vim', {'autoload' : {'filetypes' : ['haskell']}}
	NeoBundleLazy 'plasticboy/vim-markdown', {'autoload' : {'filetypes' : ['markdown']}}
	" NeoBundleLazy 'davidhalter/jedi-vim', {'autoload' : {'filetypes' : ['python']}}
	" }}}

	"" utils {{{
	NeoBundle 'thinca/vim-quickrun'
	NeoBundle 'scrooloose/nerdcommenter'
	NeoBundle 'tpope/vim-surround'
	NeoBundle 'tpope/vim-endwise'
	NeoBundle 'Townk/vim-autoclose'
	NeoBundle 'tmhedberg/matchit'
	NeoBundle 'scrooloose/syntastic'
	if has('nvim')
		NeoBundle "Shougo/deoplete.nvim"
	elseif has('lua')
		NeoBundle 'osyo-manga/vim-over'
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
	\     'linux' : 'make -j4',
	\     'unix' : 'gmake',
	\    },
	\ }
	NeoBundle 'tsukkee/unite-tag', {
	\ 'depends' : ['Shougo/unite.vim'],
	\ }
	NeoBundle 'szw/vim-maximizer'
	"" }}}

	call neobundle#end()
	NeoBundleCheck
"" }}}

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
"" }}}

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
		let g:deopletes#omni#input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

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

"" vim-markdown {{{
	if !empty(neobundle#get("vim-markdown"))
		let g:vim_markdown_folding_disabled = 1
		let g:vim_markdown_conceal = 0
		let g:tex_conceal = ""
		let g:vim_markdown_math = 1
		let g:vim_markdown_frontmatter = 1
	endif

	augroup MarkdownSettings
		autocmd!
		autocmd filetype markdown silent set expandtab
	augroup END
"" }}}

"" vim-over {{{
	if !empty(neobundle#get("vim-over"))
		let g:over_command_line_prompt = "Over > "
		hi OverCommandLineCursor cterm=bold,reverse ctermfg=46
		hi OverCommandLineCursorInsert cterm=bold,reverse ctermfg=46

		nnoremap <silent> %% :OverCommandLine<CR>%s/
		nnoremap <silent> %P y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!','g')<CR>!!gI<Left><Left><Left>
	else
		nnoremap %% :%s/
	endif
"" }}}

"" vim-quickrun {{{
	if !empty(neobundle#get("vim-quickrun"))
		" let g:quickrun_config = {}

		" let g:quickrun_config['*'] = {
					" \ 'outputter/buffer/close_on_empty' : 1 ,
					" \ }

		let g:quickrun_config = get(g:, 'quickrun_config', {})
		let g:quickrun_config._ = {
			\ 'runner'    : 'vimproc',
			\ 'runner/vimproc/updatetime' : 60,
			\ 'outputter' : 'error',
			\ 'outputter/error/success' : 'buffer',
			\ 'outputter/error/error'   : 'quickfix',
			\ 'outputter/buffer/split'  : ':rightbelow 8sp',
			\ 'outputter/buffer/close_on_empty' : 1,
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

		" nmap <silent> <F4> :QuickRun<CR>
	endif
"" }}}

"" matchit {{{
	augroup Matchit
		autocmd!
		autocmd FileType lua let b:match_words = '\<\(if\|function\|for\|while\)\>:\<\(\|then\|do\)\>:\<\(elseif\)\>:\<\(else\)\>:\<\(end\)\>'
		autocmd FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
		autocmd Filetype tex,vim let b:match_words = '（:）,【:】'
	augroup END
"" }}}

"" syntastic {{{
	if !empty(neobundle#get("syntastic"))
		let g:syntastic_check_on_open = 1
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
		let g:syntastic_lua_luacheck_options = "-g -d -a -u -r"
		let g:syntastic_moon_checkers = ['mooncheck', 'moonc']
		let g:syntastic_moon_mooncheck_options = "-g -d -a -u -r"
		let g:syntastic_sh_checkers = ['shellcheck']
		let g:syntastic_sh_shellcheck_args = ['--exclude=SC2148']
		let g:syntastic_haskell_checkers = ['ghc-mod']
		let g:syntastic_ocaml_checkers = ['merlin']
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

"" javacomplete {{{
	if !empty(neobundle#get('vim-javacomplete2'))
		augroup Javacomplete
			autocmd!
			autocmd filetype java setlocal omnifunc=javacomplete#Complete
			autocmd filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
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
		" let g:vimtex_latexmk_options = '-pdfdvi'
		let g:vimtex_latexmk_callback = 0

		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif
		let g:neocomplete#sources#omni#input_patterns.tex = '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'

		if !exists('g:deoplete#omni#input_patterns')
			let g:deoplete#omni#input_patterns = {}
		endif

		augroup VimtexSetup
			autocmd!
			autocmd filetype tex let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
			autocmd filetype tex vnoremap <silent> <LocalLeader>lf "ey
				\:call system("evince -l \"$(echo '" . @e . "' <bar> detex)\" " . fnamemodify(g:vimtex_data[0].tex, ":t:r") . ".pdf > /dev/null 2>&1")<CR>
		augroup END
	endif
"" }}}

"" rust.vim {{{
	let g:rustfmt_autosave = 1
"" }}}

"" racer {{{
	if !empty(neobundle#get('phildawes/racer'))
		set hidden
		let g:racer_cmd = $HOME . "/.vim/bundle/racer/target/release/racer"
		let $RUST_SRC_PATH = "/tmp"
		" let g:syntastic_rust_rust_exec = $HOME.  "/.vim/bundle/rust.vim/syntax_checkers/rust/rust.vim"
	endif
"" }}}

"" jedi-vim {{{
	if !empty(neobundle#get('jedi-vim'))
		command! -nargs=0 JediRename :call jedi#rename()

		let g:jedi#rename_command = ""
		let g:jedi#documentation_command = ""
	endif
"" }}}

"" vim-racket {{{
	if !empty(neobundle#get('vim-racket'))
	endif
"" }}}

"" vim-maximizer {{{
	if !empty(neobundle#get('vim-maximizer'))
		" let g:maximizer_default_mapping_key = '<F11>'
		nnoremap <silent><F11> :MaximizerToggle<CR>
		vnoremap <silent><F11> :MaximizerToggle<CR>gv
		inoremap <silent><F11> <C-o>:MaximizerToggle<CR>
	endif
"" }}}

"" ghcmod.vim {{{
	if !empty(neobundle#get('ghcmod-vim'))
		hi ghcmodType ctermbg=yellow
		let g:ghcmod_type_highlight = 'ghcmodType'
		let g:ghcmod_hlint_options = ['--ignore=Redundant $']
		let g:ghcmod_open_quickfix_function = 'GhcModQuickFix'
		function! GhcModQuickFix()
		  " for unite.vim and unite-quickfix
		  :Unite -no-empty quickfix

		  " for ctrlp
		  ":CtrlPQuickfix

		  " for FuzzyFinder
		  ":FufQuickfix
		endfunction
	endif
"" }}}

"" merlin and ocp-indent (it is not a plugin) {{{
	let g:opamshare = matchstr(substitute(system('opam config var share'), '\([^\n]\+\)\@<=\n.*$', '', ''), '^\(/[^/]\+\)\+/\?')
	if !empty(g:opamshare)
		let has_merlin = substitute(system("command -v ocamlmerlin 2>&1 >/dev/null; echo $?"), '\n\+$', '', '')
		if has_merlin == "0"
			execute 'set runtimepath+=' . g:opamshare . '/merlin/vim'
		endif

		let has_ocp_indent = substitute(system("command -v ocp-indent 2>&1 >/dev/null; echo $?"), '\n\+$', '', '')
		if has_ocp_indent == "0"
			execute 'set runtimepath^=' . g:opamshare . '/ocp-indent/vim'
			let g:ocp_indent_on = 1

			function! s:ocaml_format()
				if g:ocp_indent_on == 1
					let now_line = line('.')
					exec ':%! ocp-indent'
					exec ':' . now_line
				endif
			endfunction

			augroup OcamlFormat
				autocmd!
				autocmd BufWrite,FileWritePre,FileAppendPre *.mli\= call s:ocaml_format()
			augroup END
		endif
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
