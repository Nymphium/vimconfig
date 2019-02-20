function! s:color()
	hi link hsStructure Statement
	hi link hsKeyword Statement
	hi link hsUndefined TODO
endfunction

augroup Color
	autocmd FileType haskell call s:color()
	autocmd BufEnter *.hs call s:color()
augroup END

syn keyword hsUndefined undefined
