"" make block comment {
	function! CommentInLine()
		if &filetype =~ "lua"
			normal `<i--[[ 
			normal `>5la ]]
		else
			normal `<i/* 
			normal `>3la */
		endif
	endfunction

	vnoremap <ESC>z <ESC>:call CommentInLine()<CR>
	vnoremap <M-z> <ESC>:call CommentInLine()<CR>
"" }



"" highlighting *.swi as Prolog {
	augroup SyntaxProlog
		autocmd!
		autocmd BufNewFile *.swi set filetype=prolog
		" autocmd BufReadPost *.swi set filetype=prolog
	augroup END
"" }


"" edit TeX file {
	augroup LatexEnv
		autocmd!
		autocmd BufNewFile *.tex let g:tex_flavor = "latex"
		autocmd BufNewFile *.tex let java_highlight_all = 1
		autocmd BufNewFile *.tex let java_highlight_debug = 1
		autocmd BufNewFile *.tex let java_highlight_functions = 1
		autocmd BufWritePre *.tex silent :%s/｡/。/ge
		autocmd BufWritePre *.tex silent :%s/､/、/ge
		autocmd BufWritePre *.tex silent :%s/｢/「/ge
		autocmd BufWritePre *.tex silent :%s/｣/」/ge
		" autocmd BufWritePre *.tex silent :%s/\([lL][eE][fF][tT]\)\@<!(/（/ge
		" autocmd BufWritePre *.tex silent :%s/\([rR][iI][gG][hH][tT]\)\@<!)/）/ge
	augroup END
"" }


"" highlight Zenkaku-space {
	function! ZenkakuSpace()
		hi ZenkakuSpace cterm=underline ctermbg=196 gui=underline guifg=darkgrey
	endfunction

	if has('syntax')
		augroup ZenkakuSpace
			autocmd!
			autocmd ColorScheme       * call ZenkakuSpace()
			autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
		augroup END

		call ZenkakuSpace()
	endif
"" }


"" insertmode highlight {
	if has('syntax')
		let g:hi_insert = 'StatusLine cterm=bold ctermfg=0 ctermbg=255 guifg=#000000 guibg=#ffffff'
		let g:hi_normal = ""

		redir => g:hi_normal
			silent! hi StatusLine
		redir END

		let g:hi_normal = substitute(hi_normal, '[\r\n]', '', 'g')
		let g:hi_normal = substitute(hi_normal, 'xxx ', '', '')

		augroup InsertHighlight
			autocmd!
			autocmd InsertEnter * exec 'hi '. g:hi_normal
			autocmd InsertLeave * exec 'hi '. g:hi_insert
		augroup END
	endif
"" }


"" gui-transparency {
	if has('gui_running')
		function! s:Transset(opacity)
		  call system('transset-df --id ' . v:windowid . ' ' . a:opacity)
		endfunction

		command! -nargs=1 Transset call <SID>Transset(<q-args>)
	endif
""  }


"" set-shellscript filetype {
	function! DetectFromShebang()
		if strlen(&ft) > 1
			return
		endif

		let s:l = line(".")
		let s:c = col(".")
		normal gg
		let s:line = getline(".")
		let s:this_ft = matchstr(s:line, '\(^#!.\{-}\/bin\/.\{-}\)\@<=\w\+$')

		if strlen(s:this_ft) > 0
			if s:this_ft == "bash" || s:this_ft == "zsh"
				let s:this_ft = "sh"
			endif

			let s:this_ft = "set ft=" . s:this_ft

			execute (s:this_ft)
		endif

		call cursor(s:l, s:c)
	endfunction

	if strlen(&ft) < 1
		augroup DetectFromShebangAndHighlightAgain
			autocmd!
			autocmd BufWritePost * call DetectFromShebang()
			autocmd BufWritePost * syn match Shebang /^#!\/.\{-\}bin\/.*$/
		augroup END
	endif
"" }

