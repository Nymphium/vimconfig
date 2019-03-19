let s:called = 0

" expected yats.vim

function! s:color()
	if !s:called
		let s:called = 1
		hi tsKeywords cterm=bold ctermfg=yellow
		hi link typescriptExceptions tsKeywords
		hi link typescriptBraces Bracket
		hi link typescriptParens Bracket
		hi link typescriptBinaryOp tsKeywords
		hi link typescriptTernaryOp tsKeywords

		" keywords
		hi link typescriptAliasKeyword tsKeywords
		hi link typescriptReserved tsKeywords
		hi def link typescriptSymbols tsKeywords
		hi link typescriptUnaryOp tsKeywords
		hi link typescriptVariable tsKeywords
		hi link typescriptFuncKeyword MoreFunction
		hi link typescriptEndcolons tsKeywords
	endif
endfunction

augroup TSColor
	autocmd!
	autocmd ColorScheme * call s:color()
augroup END

" syn match Type /<\|>/
" syn keyword tsKeywords const
" syn keyword tsKeywords var
" syn keyword tsKeywords let

