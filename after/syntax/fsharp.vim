" Vim syntax file
" Language: F#
" Maintainer: Nymphium

let fsharp_highlighted = 0

function! s:color()
	hi link fsharpKeyword Statement
	hi link fsharpOp Statement
	hi link fsharpKeyChar Type
	hi link fsharpIf Type
	hi link fsharpDoubleSemicolon Type
	hi link fsharpSymbol fsharpIf
	hi link fsharpBracket Special
	hi link fsharpArrayBegin Special
	hi link fsharpFunction MoreFunction
	hi fsharpWild cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7
	hi link fsharpEffKeyword Identifier
endfunction

function! s:yaccolor()
	hi link fsharpyaccToken Identifier
	hi link fsharpyaccComment Comment
	hi link fsharpyaccTerm Include
	hi link fsharpyaccDollarterm Include
	hi link fsharpyaccTypeset Type
endfunction

augroup fsharpColor
	autocmd!
	autocmd ColorScheme *
				\  call s:color()
				\| call s:yaccolor()
augroup END

syn match fsharpKeyword /\(\s\+\)\@<=to\(\s\+\)\@=/
syn match fsharpDoubleSemicolon /\<;;\>/
syn match fsharpOp /[^'#0-9A-Za-z_\s"\((*\)\(*)\)]\+/
" syn match fsharpFunc /\(\<let\s\+\(rec\s\+\)\{0,1\}\)\@<=\w\+\>/
" syn match fsharpFunc /\(\<and\s\+\)\@<=\w\+\>/
syn match fsharpBracket /[(){}\[]\]/
syn match fsharpArrayBegin "\[|"
syn match fsharpArrayEnd "|\]"
" syn match fsharpModuleAccess /\([A-Z]\w*\)\@<=\./
syn keyword fsharpFunction fun
syn keyword fsharpFunction function
syn keyword fsharpWild _
syn keyword fsharpKeyword effect

syn keyword fsharpEffKeyword perform continue

syn match fsharpyaccToken '%\S\+'
syn match fsharpyaccComment /\/\/.*/
syn match fsharpyaccTerm /\<[a-z_']\+\>:/
syn match fsharpyaccTerm /\$\d\+/
syn match fsharpyaccTypeset /<[^>]\+>/

