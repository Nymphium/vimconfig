" Vim syntax file
" Language: OCaml
" Maintainer: Nymphium

function! s:color()
	hi link ocamlKeyword Statement
	hi link ocamlEqual ocamlKeyword
	hi link ocamlKeyChar ocamlKeyword
	hi link ocamlInfixOp Statement
	hi link ocamlPrefixOp Statement
	hi link ocamlLetOp ocamlInfixOp
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
syn match ocamlBracket /[(){}\[]\]/
syn match ocamlArrayBegin "\[|"
syn match ocamlArrayEnd "|\]"
syn match ocamlKeyChar /[,:]/
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

