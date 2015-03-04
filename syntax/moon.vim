" Vim syntax file
" Language: MoonScript
" Maintainer: Nymphium


hi moonFunction cterm=bold gui=bold ctermfg=214 guifg=#ffaf87
hi moonChar cterm=bold gui=bold
hi moonMetatable cterm=bold gui=bold
hi link moonKeyword Statement
hi link moonBracket Special
hi link moonConditional Type
hi link moonGlobal Boolean

syn clear moonShortHandAssign
syn clear moonObjAssign
syn match moonChar /[=%<>/+\*,]/ contained display
syn match moonKeyword ":"

syn match moonLuaFunc /\<\w\+\>\(\s*=\?\s*(\)\@=/
syn match moonLuaFunc /\w\+\(\(:\|\(\s*=\)\)\?\s*\((.\{-\})\)\?\s*\(=\|-\)>\)\@=/
syn match moonLuaFunc /\<\w\+\>\(!\)\@=/

syn match moonBracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/
syn match moonMetatable  /\<__\(index\|newindex\|mode\|call\|metatable\|tostring\|len\|gc\|unm\|add\|sub\|mul\|div\|modd|pow\|concat\|eq\|lt\|gt\|class\|name\|inherited\)\>/

