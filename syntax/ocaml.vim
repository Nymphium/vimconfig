" Vim syntax file
" Language: OCaml
" Maintainer: Nymphium


hi link ocamlKeyword Statement
hi link ocamlOp Statement
hi link ocamlKeyChar Type
" hi link ocamlFunc Identifier
hi link ocamlIf Type
hi link ocamlDoubleSemicolon Type
hi link ocamlSymbol ocamlIf
hi link ocamlBracket Special
hi link ocamlArrayBegin Special
" hi link ocamlModuleAccess Special
hi ocamlFunction cterm=bold gui=bold ctermfg=214 guifg=#ffaf87
hi ocamlWild cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7

syn match ocamlKeyword /\(\s\+\)\@<=to\(\s\+\)\@=/
syn match ocamlDoubleSemicolon /\<;;\>/
syn match ocamlOp /[^'#0-9A-Za-z_\s"\((*\)\(*)\)]\+/
" syn match ocamlFunc /\(\<let\s\+\(rec\s\+\)\{0,1\}\)\@<=\w\+\>/
" syn match ocamlFunc /\(\<and\s\+\)\@<=\w\+\>/
syn match ocamlBracket /[(){}\[]\]/
syn match ocamlArrayBegin "\[|"
syn match ocamlArrayEnd "|\]"
" syn match ocamlModuleAccess /\([A-Z]\w*\)\@<=\./
syn keyword ocamlFunction fun
syn keyword ocamlFunction function
syn keyword ocamlWild _
syn keyword ocamlKeyword effect

hi link ocamlEffKeyword Identifier
syn keyword ocamlEffKeyword perform continue

augroup OcamlHighlight
	autocmd!
	autocmd BufEnter *.mly hi link ocamlyaccToken Identifier
	autocmd BufEnter *.mly hi link ocamlyaccComment Comment
	autocmd BufEnter *.mly hi link ocamlyaccTerm Include
	autocmd BufEnter *.mly hi link ocamlyaccDollarterm Include
	autocmd BufEnter *.mly hi link ocamlyaccTypeset Type
	autocmd BufEnter *.mly syn match ocamlyaccToken '%\S\+'
	autocmd BufEnter *.mly syn match ocamlyaccComment /\/\/.*/
	autocmd BufEnter *.mly syn match ocamlyaccTerm /\<[a-z_']\+\>:/
	autocmd BufEnter *.mly syn match ocamlyaccTerm /\$\d\+/
	autocmd BufEnter *.mly syn match ocamlyaccTypeset /<[^>]\+>/
augroup END

