" Vim syntax file
" Language: C
" Maintainer: Nymphium


hi link cChar cType
hi link cFunc cInclude
hi link cSurround Special

syn match cChar /[!=%<>+,\(\->\)\-]/
syn match cChar /\/\(\*\|\/\)\@!/
syn match cChar /\(\/\)\@<!\*/
syn match cFunc /\(\<\(\(int\)\|\(void\)\|\(char\)\|\(double\)\|\(float\)\)\s\+\)\@<=\w\+\(\s*(.*)\)\@=/
syn match cFunc /\<\w\+\>\(\s*(.*)\)\@=/ contains=ALLBUT,cStatement,cLabel,cConditional,cRepeat,cUserLabel,cOperator,cStructure

augroup CSyn
	autocmd!
	autocmd VimEnter *.c,*.cpp syn match cSurround /[(){}\[\]]/
augroup END

