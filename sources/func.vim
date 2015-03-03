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

	function! SyncTexForward()
		let execstr = "silent !xdg-open %:p:r.pdf &"
		exec execstr
	endfunction

	nmap <Leader>f :call SyncTexForward()<CR>
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
		let g:hi_insert = 'StatusLine cterm=reverse,bold ctermfg=0 ctermbg=255'
		let g:hi_normal = ""

		redir => g:hi_normal
			silent! hi StatusLine
		redir END

		let g:hi_normal = substitute(hi_normal, '[\r\n]', '', 'g')
		let g:hi_normal = substitute(hi_normal, 'xxx ', '', '')

		augroup InsertHighlight
			autocmd!
			autocmd InsertEnter * exec 'hi '. g:hi_insert
			autocmd InsertLeave * exec 'hi '. g:hi_normal
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
