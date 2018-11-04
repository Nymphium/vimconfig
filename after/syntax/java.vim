" Vim syntax file
" Language: Java
" Maintainer: Nymphium


augroup JavaColor
	autocmd!
	autocmd ColorScheme * hi link javaMethod Include
	autocmd ColorScheme * hi link javaBraces Special
	autocmd ColorScheme * hi link javaClass javaType
	autocmd ColorScheme * hi link javaScopeDecl Statement
	autocmd ColorScheme * hi link javaClassDecl Statement
	autocmd ColorScheme * hi link javaStorageClass Statement
	autocmd ColorScheme * hi javaLambda cterm=bold gui=bold ctermfg=214 guifg=#af00af
augroup END


" Syntastic will resolve
syn clear javaError

syn match javaMethod /\<[a-z]\w*\(\s*(.*)\)\@=/ display
syn match javaClass /\(class\s\+\)\@<=[A-Z]\w\+/ display
syn match javaClass /\(new\s\+\)\@<=[A-Z]\w*/ display

syn match javaClass /\<[A-Z]\w*\(\.\)\@=/ display
syn match javaBraces /[()\[\]{}]/ display
syn match javaLambda /\s*\zs->\ze\s*/ contains=NONE display
syn match javaBraces /\(<\)\(\a*\)\@=\(>\)/ display
syn match GenericsType /\(<\)\@<=\a\+\(>\)\@=/ contained
syn region Type matchgroup=javaBraces start=/<\(\a\+>\)\@=/ end=/\(<\a\+\)\@<=>/ oneline
