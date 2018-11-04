augroup TSColor
	autocmd!
	autocmd Colorscheme * hi tsKeywords cterm=bold ctermfg=yellow
	autocmd ColorScheme * hi link typescriptReserved tsKeywords
	autocmd ColorScheme * hi link typescriptFuncKeyword MoreFunction
	autocmd ColorScheme * hi link typescriptExceptions tsKeywords
	autocmd ColorScheme * hi link tsBrac Special
augroup END

syn keyword tsKeywords const
syn keyword tsKeywords var
syn keyword tsKeywords let
syn match tsBrac /(\|)\|{\|}\|\[\|\]/
syn match typescriptOperator /?\|:/

