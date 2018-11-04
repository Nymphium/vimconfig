" Vim syntax file
" Language: C
" Maintainer: Nymphium


" hi link cChar cType
augrou CColor
	autocmd!
	autocmd ColorScheme c hi link cFunc Identifier
	autocmd ColorScheme c hi link cSurround Special
augroup END

syn match cOperator /[!=%<>+\(\->\)\-\.]/ display
syn match cOperator /\/\(\*\|\/\)\@!/ display
syn match cOperator /\(\/\)\@<!\*/ display
syn match cFunc /\(\<\(\(int\)\|\(void\)\|\(char\)\|\(double\)\|\(float\)\)\s\+\)\@<=\w\+\(\s*(.*)\)\@=/ display
syn match cFunc /\<\w\+\>\(\s*(.*)\)\@=/ contains=ALLBUT,cStatement,cLabel,cConditional,cRepeat,cUserLabel,cOperator,cStructure display
syn match cSurround /[(){}\[\]]/

