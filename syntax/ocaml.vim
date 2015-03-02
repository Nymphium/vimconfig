" Vim syntax file
" Language: OCaml
" Maintainer: Nymphium


hi link ocamlKeyword Statement
hi link ocamlKeyChar Type
hi link ocamlFunc Identifier
hi link ocamlIf Type
hi link ocamlDoubleSemicolon Type
hi link ocamlArrow ocamlKeyword
hi link ocamlSymbol ocamlIf
hi link ocamlBracket Special

syn match ocamlKeyword /\(\s\+\)\@<=to\(\s\+\)\@=/
syn match ocamlDoubleSemicolon /\<;;\>/
syn match ocamlSymbol /[@<>]/
" syn match ocamlFunc "\(\w\+\s\+\)\@<!\w\+\(\(\s\+\w\+\)\{1,\}\)\@=" contains=ALLBUT,ocamlKeyword,ocamlNone
syn match ocamlFunc /\(\<let\s\+\(rec\s\+\)\{0,1\}\)\@<=\w\+\>/
syn match ocamlFunc /\(\<and\s\+\)\@<=\w\+\>/
syn match ocamlFunc /\<print_\h\+\>/
syn match ocamlSymbol /:\{-2\}/
syn match ocamlArrow /|\(\s*.\{-\}->\)\@=/
syn match ocamlArrow /|\(\s*.\{-\}of\)\@=/
syn match ocamlArrow /\(|\s.\{-\}\)\@<=->/
syn match ocamlBracket /[(){}\[]\]/

