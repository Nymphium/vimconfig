" Vim syntax file
" Language: MoonScript
" Maintainer: Nymphium


hi moonFunction cterm=bold gui=bold ctermfg=214 guifg=#ffaf87
hi moonChar cterm=bold gui=bold
hi moonMetatable cterm=bold gui=bold
hi moonObjAssign cterm=bold gui=bold
hi moonLength cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7
hi moonTable cterm=bold gui=bold
hi link moonKeyword Statement
hi link moonBracket Special
hi link moonConditional Type
hi link moonGlobal Boolean

syn clear moonShortHandAssign
syn clear moonObjAssign

syn match moonChar /[=%<>/+\*,]/ contained display

syn match moonKeyword ":"

syn match moonObjAssign /\<\w\+\>\(:\s*\(\((.\{-\})\)\?-\|=>\)\?\)\@=/ display
syn match moonObjAssign /\(\s\+:\)\@<=\<\w\+\>/ display

syn match moonLength /#\(\w\+[\.:]\?\)\+/ display
syn match moonLength /#{\(.*\)\@=}/ display
syn region moonTableLength matchgroup=moonLength start="#{" end="}" contains=ALL

syn match moonTable /\zs\<\w\+\>\ze\.\(\.\)\@!/ display
syn match moonTable /\<\w\+\>\(\[\)\@=/ display
syn match moonTable /\<\w\+\>\(\\\)\@=/ display

syn match moonOperator "\~=" display

syn match moonLuaFunc /\<\w\+\>\(\s*=\?\s*(\)\@=/ display
syn match moonLuaFunc /\w\+\(\(:\|\(\s*=\)\)\?\s*\((.\{-\})\)\?\s*\(=\|-\)>\)\@=/ display
syn match moonLuaFunc /\<\w\+\>\(!\)\@=/ display
syn match moonLuaFunc /\(\\\)\@<=\<\w\+\>/ display

syn match moonBracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/

syn match moonMetatable  /__\(index\|newindex\|mode\|call\|metatable\|tostring\|len\|gc\|unm\|add\|sub\|mul\|div\|modd|pow\|concat\|eq\|lt\|gt\|class\|name\|inherited\)\>/ display

