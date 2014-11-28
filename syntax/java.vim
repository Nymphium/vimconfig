hi link javaMethod Include
hi link javaBracket Special
hi link javaClass javaClassDecl
hi link javaScopeDecl Statement


syn match javaMethod display /\<[a-z]\w*\(\s*(.*)\)\@=/
syn match javaClass display /\(class\s\+\)\@<=[A-Z]\w\+/
syn match javaClass display /\(new\s\+\)\@<=[A-Z]\w*/
autocmd VimEnter *.java syn match javaClass display /\<[A-Z]\w*\(\.\)\@=/
autocmd VimEnter *.java syn match javaBracket display /[(){}\[\]]/
