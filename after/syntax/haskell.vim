function! s:color()
	hi link hsStructure Statement
	hi link hsKeyword Statement
	hi link hsUndefined TODO
endfunction

augroup Color
	autocmd colorscheme * call s:color()
augroup END

syn keyword hsUndefined undefined
