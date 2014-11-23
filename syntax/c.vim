hi link cChar cType
hi link cFunc cInclude
hi link cSurround String

syn match cChar "[!=%<>+,\(\->\)\-]"
syn match cChar "/\(\*\|/\)\@!"
syn match cChar "\(/\)\@<!\*"
syn match cFunc "\(\<\(\(int\)\|\(void\)\|\(char\)\|\(double\)\|\(float\)\)\s\+\)\@<=\w\+\(\s*(.*)\)\@="
syn match cFunc display /\<\w\+\>\(\s*(.*)\)\@=/ contains=ALLBUT,cStatement,cLabel,cConditional,cRepeat,cUserLabel,cOperator

autocmd VimEnter,FileType * if &filetype == "c" | syn match cSurround display /[(){}\[\]]/ | endif

