" Vim syntax file
" Language: Java
" Maintainer: Nymphium


hi link javaMethod Include
hi link javaBraces Special
hi link javaClass javaType
hi link javaScopeDecl Statement
hi link javaClassDecl Statement
hi link javaStorageClass Statement


syn match javaMethod /\<[a-z]\w*\(\s*(.*)\)\@=/
syn match javaClass /\(class\s\+\)\@<=[A-Z]\w\+/
syn match javaClass /\(new\s\+\)\@<=[A-Z]\w*/

autocmd VimEnter *.java syn clear javaFuncDef
autocmd VimEnter *.java syn match javaClass /\<[A-Z]\w*\(\.\)\@=/
autocmd VimEnter *.java syn match javaBraces /[()\[\]]/

