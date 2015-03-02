" Vim syntax file
" Language: C
" Maintainer: Nymphium


hi link cChar cType
hi link cFunc cInclude
hi link cSurround Special

syn match cChar /[!=%<>+,\(\->\)\-]/ display
syn match cChar /\/\(\*\|\/\)\@!/ display
syn match cChar /\(\/\)\@<!\*/ display
syn match cFunc /\(\<\(\(int\)\|\(void\)\|\(char\)\|\(double\)\|\(float\)\)\s\+\)\@<=\w\+\(\s*(.*)\)\@=/ display
syn match cFunc /\<\w\+\>\(\s*(.*)\)\@=/ contains=ALLBUT,cStatement,cLabel,cConditional,cRepeat,cUserLabel,cOperator,cStructure display
syn match cSurround /[(){}\[\]]/

