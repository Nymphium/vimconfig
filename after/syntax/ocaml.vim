" Vim syntax file
" Language: OCaml
" Maintainer: Nymphium


augroup OCamlColor
	autocmd!
	autocmd ColorScheme * hi link ocamlKeyword Statement
	autocmd ColorScheme * hi link ocamlOp Statement
	autocmd ColorScheme * hi link ocamlKeyChar Type
	autocmd ColorScheme * hi link ocamlIf Type
	autocmd ColorScheme * hi link ocamlDoubleSemicolon Type
	autocmd ColorScheme * hi link ocamlSymbol ocamlIf
	autocmd ColorScheme * hi link ocamlBracket Special
	autocmd ColorScheme * hi link ocamlArrayBegin Special
	autocmd ColorScheme * hi link ocamlFunction MoreFunction
	autocmd ColorScheme * hi ocamlWild cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7
	autocmd ColorScheme * hi link ocamlEffKeyword Identifier
augroup END

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

