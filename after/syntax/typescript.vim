function! s:color()
	hi tsKeywords cterm=bold ctermfg=yellow
	hi link typescriptReserved tsKeywords
	hi link typescriptFuncKeyword MoreFunction
	hi link typescriptExceptions tsKeywords
	hi link tsBrac Bracket
endfunction

augroup TSColor
	autocmd!
	autocmd FileType typescript, typescript.tsx call s:color()
	autocmd BufEnter *.ts,*.tsx call s:color()
augroup END

syn keyword tsKeywords const
syn keyword tsKeywords var
syn keyword tsKeywords let
syn match tsBrac /(\|)\|{\|}\|\[\|\]/
syn match typescriptOperator /?\|:/

