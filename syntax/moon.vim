" Vim syntax file
" Language: MoonScript
" Maintainer: Nymphium
"
" It's assuming to use leafo/moonscrpt-vim(https://github.com/leafo/moonscript-vim)


hi moonFunction cterm=bold gui=bold ctermfg=214 guifg=#ffaf87
hi moonChar cterm=bold gui=bold
hi moonMetatable cterm=bold gui=bold
hi moonObjAssign cterm=bold gui=bold
hi moonLength cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7
hi moonTable cterm=bold gui=bold
hi link moonInterpDelim Special
hi link moonKeyword Statement
hi link moonBracket Special
hi link moonConditional Type
hi link moonGlobal Boolean

syn clear moonShortHandAssign
syn clear moonObjAssign
syn clear moonDotAccess
syn clear moonFunction

syn match moonChar /[=%<>/+\*,\.]/ contained display

syn match moonKeyword ":"

syn match moonObjAssign /\<\w\+\>\(:\s*\(\((.\{-\})\)\?-\|=>\)\?\)\@=/ display
syn match moonObjAssign /\(\s\+:\)\@<=\<\w\+\>/ display

syn match moonLength /#\(@\?\w\+[\.:]\?\)\+/ display
syn match moonLength /#{\(.*\)\@=}/ display
syn region moonTableLength matchgroup=moonLength start="#{" end="}" display transparent oneline

syn match moonTable /\zs\<\w\+\>\ze\.\(\.\)\@!/ display
syn match moonTable /\<\w\+\>\(\[\)\@=/ display
syn match moonTable /\<\w\+\>\(\\\)\@=/ display

syn match moonOperator "\~=" contains=NONE display
syn match moonOperator "!=" contains=NONE display

syn match moonFunction /->\|=>/ display

syn match moonLuaFunc /\<\w\+\>\(\s*\s*(\)\@=/ display contains=ALLBUT,Normal
syn match moonLuaFunc /\<\w\+\>\(\(:\|\(\s*=\)\)\(\s*(.*)\)\?\s*\(=\|-\)>\)\@=/ display
syn match moonLuaFunc /@\?\w\+\(!\)\@=/ display
syn match moonLuaFunc /\(\\\)\@<=\<\w\+\>/ display

syn match moonBracket /[(){}]\|\[\|\]/ containedin=moonString,moonString2,moonBasic

syn match moonMetatable  /\<__\(index\|newindex\|mode\|call\|metatable\|tostring\|len\|gc\|unm\|add\|sub\|mul\|div\|modd|pow\|concat\|eq\|lt\|gt\|class\|name\|inherited\)\>/ display

