" Vim syntax file
" Language: Java
" Maintainer: Nymphium


hi link javaMethod Include
hi link javaBraces Special
hi link javaClass javaType
hi link javaScopeDecl Statement
hi link javaClassDecl Statement
hi link javaStorageClass Statement
hi javaLambda cterm=bold gui=bold ctermfg=214 guifg=#af00af


" Syntastic will resolve
syn clear javaError

syn match javaMethod /\<[a-z]\w*\(\s*(.*)\)\@=/ display
syn match javaClass /\(class\s\+\)\@<=[A-Z]\w\+/ display
syn match javaClass /\(new\s\+\)\@<=[A-Z]\w*/ display

syn match javaClass /\<[A-Z]\w*\(\.\)\@=/ display
syn match javaBraces /[()\[\]{}]/ display
syn match javaLambda /\s*\zs->\ze\s*/ contains=NONE display

