" Vim syntax file
" Language: Lua
" Maintainer: Nymphium


hi luaFunction cterm=bold ctermfg=214
hi luaLength cterm=bold ctermfg=62
hi link luaBracket Special
hi luaCond cterm=bold ctermfg=48
hi link luaElse luaCond
hi luaChar cterm=bold
hi link luaTableName Structure
hi luaMetatable cterm=bold

"" '=', '%', '<', '>', '/', '+', '*', ',', '-', ".."
syn match luaChar /[=%<>/+\*,]/ contained display
syn match luaChar /\([\w\s]\)\@<=\.\.\([\w\s]\)\@=/ contained display
syn match luaChar /-\(-\)\@!/ contained display

" #table 
syn match luaLength /#\w\+\>/ display
syn match luaTableName /\w\+\([\.:]\)\@=/
syn match luaTableName /\<\w\+\>\(\s*\[\)\@=/ display

" ??? I edited /PATH/TO/vim/syntax/lua.vim
" syn match luaFunc /\<\w\+\>\(\s*(.*\)\@=/ contains=ALLBUT,luaKeyword,luaOperator,luaIn,luaStatement

syn match luaFunc /\<\w\+\>\(\s*=\s*function\)\@=/ display
syn match luaBracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/
syn match luaMetatable  /\<__\(index\|newindex\|mode\|call\|metatable\|tostring\|len\|gc\|unm\|add\|sub\|mul\|div\|idiv\|mod\|pow\|concat\|eq\|lt\|gt\|ipairs\)\>/

