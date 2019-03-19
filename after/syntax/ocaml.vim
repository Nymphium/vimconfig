" Vim syntax file
" Language: OCaml
" Maintainer: Nymphium

function! s:color()
	hi link ocamlKeyword Statement
	hi link ocamlOp Statement
	hi link ocamlKeyChar Type
	hi link ocamlIf Type
	hi link ocamlDoubleSemicolon Type
	hi link ocamlSymbol ocamlIf
	hi link ocamlBracket Special
	hi link ocamlArrayBegin Special
	hi link ocamlFunction MoreFunction
	hi ocamlWild cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7
	hi link ocamlEffKeyword Identifier
endfunction

function! s:yaccolor()
	hi link ocamlyaccToken Identifier
	hi link ocamlyaccComment Comment
	hi link ocamlyaccTerm Include
	hi link ocamlyaccDollarterm Include
	hi link ocamlyaccTypeset Type
endfunction

augroup OCamlColor
	autocmd!
	autocmd ColorScheme *
				\  call s:color()
				\| call s:yaccolor()
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

syn match ocamlyaccToken '%\S\+'
syn match ocamlyaccComment /\/\/.*/
syn match ocamlyaccTerm /\<[a-z_']\+\>:/
syn match ocamlyaccTerm /\$\d\+/
syn match ocamlyaccTypeset /<[^>]\+>/

