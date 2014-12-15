" Vim syntax file
" Language: Lua
" Maintainer: Nymphium


hi luaFunction cterm=bold ctermfg=214
hi luaLength cterm=bold ctermfg=62
hi link luaBracket Special
hi luaCond cterm=bold ctermfg=48
hi link luaElse luaCond
hi luaChar cterm=bold

syn match luaChar /[=%<>/+\*,]/ contained
syn match luaChar /\([\w\s]\)\@<=\.\.\([\w\s]\)\@=/ contained
syn match luaChar /-\(-\)\@!/ contained
syn match luaLength /#\w\+\>/
syn match luaTable /\w\+\([\.:]\)\@=/
syn match luaTable /\w\+\s*\(=\_s*\)\@=/
syn match luaFunc /\<\w\+\>\(\s*(.*)\)\@=/ contains=ALLBUT,luaCond,luaKeyword,luaFunction,luaOperator,luaIn,luaStatement
syn match luaFunc /\<\w\+\>\(\s*=\s*function\)\@=/

" autocmd VimEnter *.lua syn match luaBracket /[(){}\[\]]/ 
autocmd VimEnter *.lua syn region luaString start="\[\[" end="\]\]" contains=ALL skipnl skipwhite skipempty

