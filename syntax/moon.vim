" Vim syntax file
" Language: MoonScript
" Maintainer: Nymphium


hi moonFunction cterm=bold ctermfg=214
hi moonChar cterm=bold
hi link moonKeyword Statement
hi link moonBracket Special
hi link moonConditional Type
hi moonMetatable cterm=bold

syn clear moonShortHandAssign
syn clear moonObjAssign
syn match moonChar /[=%<>/+\*,]/ contained display
syn match moonKeyword ":"

syn match moonLuaFunc /\<\w\+\>\(\s*=\?\s*(\)\@=/
syn match moonLuaFunc /\w\+\(\(:\|\(\s*=\)\)\?\s*\((.\{-\})\)\?\s*\(=\|-\)>\)\@=/
syn match moonLuaFunc /\<\w\+\>\(!\)\@=/

syn match moonBracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/
syn match moonMetatable  /\<__\(index\|newindex\|mode\|call\|metatable\|tostring\|len\|gc\|unm\|add\|sub\|mul\|div\|modd|pow\|concat\|eq\|lt\|gt\|class\|name\|inherited\)\>/

