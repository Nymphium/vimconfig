" Vim syntax file
" Language: C
" Maintainer: Nymphium

function! s:color()
	hi link cFunc Identifier
	hi link cSurround Special
endfunction

" hi link cChar cType
augrou CColor
	autocmd!
	autocmd ColorScheme * call s:color()
	autocmd BufEnter *.c call s:color()
	autocmd FileType c call s:color()
augroup END

syn match cOperator /[!=%<>+\(\->\)\-\.]/ display
syn match cOperator /\/\(\*\|\/\)\@!/ display
syn match cOperator /\(\/\)\@<!\*/ display
syn match cFunc /\(\<\(\(int\)\|\(void\)\|\(char\)\|\(double\)\|\(float\)\)\s\+\)\@<=\w\+\(\s*(.*)\)\@=/ display
syn match cFunc /\<\w\+\>\(\s*(.*)\)\@=/ contains=ALLBUT,cStatement,cLabel,cConditional,cRepeat,cUserLabel,cOperator,cStructure display
syn match cSurround /[(){}\[\]]/

