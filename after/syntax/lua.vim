" Vim syntax file
" Language: Lua
" Maintainer: Nymphium

function! s:color()
	hi link luaFunction MoreFunction
	hi luaLength cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7
	hi luaCond cterm=bold gui=bold ctermfg=48 guifg=#00ff87
	hi link luaElse luaCond
	hi link luaCamma Special
	hi link luaChar Statement
	hi link luaTableName Structure
	hi luaMetatable cterm=bold gui=bold
	hi link luaRoundBrac Special
	hi link luaTable Special
	hi link luaSquareBrac Special
endfunction

augroup LuaColor
	autocmd!
	autocmd ColorScheme * call s:color()
	autocmd FileType lua call s:color()
	autocmd BufEnter *.lua call s:color()
augroup END

"" '=', '%', '<', '>', '/', '+', '*', ',', '-', ".."
syn match luaChar /[=%<>/+\*\^\~]/ display
syn match luaCamma "," display
syn match luaChar /\(\.\)\@<!\.\{2\}\(\.\)\@!/ display
syn match luaChar /-\(-\)\@!/ display

" #table 
syn match luaLength /#\(\w\+[\.:]\?\)\+/ display
syn match luaLength /#{\(.*\)\@=}/ display
syn region luaTableLength matchgroup=luaLength start="#{" end="}" contains=ALLBUT,luaBraceError,luaTodo,luaSpecial,luaIfThen,luaElseifThen,luaElse,luaThenEnd,luaBlock,luaLoopBlock,luaIn,luaStatement

syn match luaTableName /\w\+\([\.:]\)\@=\(\.\)\@!/ display
syn match luaTableName /\<\w\+\>\(\s*\[\)\@=/ display

" function name
syn clear luaFunctionBlock
syn clear luaLoopBlock
syn clear luaIfThen
syn clear luaElseifThen
syn match luaFunc /\<\w\+\>\(\s*(.*\)\@=/ contains=ALLBUT,luaKeyword,luaOperator,luaIn,luaStatement
syn region luaFunctionBlock transparent matchgroup=luaFunction start="\<function\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaElseifThen,luaElse,luaThenEnd,luaIn
syn region luaLoopBlock transparent matchgroup=luaRepeat start="\<while\>" end="\<do\>"me=e-2 contains=ALLBUT,luaTodo,luaSpecial,luaIfThen,luaElseifThen,luaElse,luaThenEnd,luaIn nextgroup=luaBlock skipwhite skipempty
syn region luaLoopBlock transparent matchgroup=luaRepeat start="\<repeat\>" end="\<until\>"   contains=ALLBUT,luaTodo,luaSpecial,luaElseifThen,luaElse,luaThenEnd,luaIn
syn region luaLoopBlock transparent matchgroup=luaRepeat start="\<for\>" end="\<do\>"me=e-2   contains=ALLBUT,luaTodo,luaSpecial,luaIfThen,luaElseifThen,luaElse,luaThenEnd nextgroup=luaBlock skipwhite skipempty
syn region luaIfThen transparent matchgroup=luaCond start="\<if\>" end="\<then\>"me=e-4           contains=ALLBUT,luaTodo,luaSpecial,luaElseifThen,luaElse,luaIn nextgroup=luaThenEnd skipwhite skipempty
syn region luaElseifThen contained transparent matchgroup=luaCond start="\<elseif\>" end="\<then\>" contains=ALLBUT,luaTodo,luaSpecial,luaElseifThen,luaElse,luaThenEnd,luaIn

syn match luaFunc /\<\w\+\>\(\s*=\s*function\>\)\@=/ display
syn match luaMetatable  /\<__\(index\|newindex\|mode\|call\|metatable\|tostring\|len\|gc\|unm\|add\|sub\|mul\|div\|idiv\|mod\|pow\|concat\|eq\|lt\|gt\|ipairs\|band\|bor\|bxor\|bnot\|shl\|shr\)\>/ display
syn region luaParen transparent  matchgroup=luaRoundBrac start='(' end=')' contains=ALLBUT,luaParenError,luaTodo,luaSpecial,luaIfThen,luaElseifThen,luaElse,luaThenEnd,luaBlock,luaLoopBlock,luaIn,luaStatement
" syn region luaIndexing transparent  matchgroup=luaSquareBrac start=/\(=\|\[\)\@<!\[\(=\|\[\)\@!/ end=/\(=\|\]\)\@<!\]\(=\|\]\)\@!/ contains=ALLBUT,luaParenError,luaTodo,luaSpecial,luaIfThen,luaElseifThen,luaElse,luaThenEnd,luaBlock,luaLoopBlock,luaIn,luaStatement
