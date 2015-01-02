" Vim syntax file
" Language: OCaml
" Maintainer: Nymphium


hi ocamlKeyword cterm=bold ctermfg=226
hi ocamlKeyChar cterm=bold ctermfg=47
hi ocamlFunc cterm=bold ctermfg=81
hi link ocamlIf Type
hi ocamlDoubleSemicolon cterm=bold ctermfg=48
hi link ocamlArrow ocamlKeyword
hi link ocamlSymbol ocamlIf
hi link ocamlBracket Special

syn match ocamlKeyword /\(\s\+\)\@<=to\(\s\+\)\@=/
syn match ocamlDoubleSemicolon /\<;;\>/
syn match ocamlSymbol "@"

augroup OcamlSyn
	autocmd!
	autocmd VimEnter *.nl syn match ocamlFunc "\(\w\+\s\+\)\@<!\w\+\(\(\s\+\w\+\)\{1,\}\)\@=" contains=ALLBUT,ocamlKeyword,ocamlNone
	autocmd VimEnter *.ml syn match ocamlFunc /\(\<let\s\+\(rec\s\+\)\{0,1\}\)\@<=\w\+\>/
	autocmd VimEnter *.ml syn match ocamlFunc /\(\<and\s\+\)\@<=\w\+\>/
	autocmd VimEnter *.ml syn match ocamlFunc /\<print_\h\+\>/
	autocmd VimEnter *.ml syn match ocamlSymbol /:\{-2\}/
	autocmd VimEnter *.ml syn match ocamlArrow /|\(\s*.\{-\}->\)\@=/
	autocmd VimEnter *.ml syn match ocamlArrow /|\(\s*.\{-\}of\)\@=/
	autocmd VimEnter *.ml syn match ocamlArrow /\(|\s.\{-\}\)\@<=->/
	autocmd VimEnter *.ml syn match ocamlBracket /[(){}\[]\]/
augroup END

