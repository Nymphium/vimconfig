" Vim syntax file
" Language: MoonScript
" Maintainer: Nymphium


hi moonFunction cterm=bold ctermfg=214
hi moonChar cterm=bold
hi link moonKeyword Statement
hi link moonBracket Special

syn match moonChar /[=%<>/+\*,]/ contained display

syn match moonLuaFunc /\<\w\+\>\(\s*=\s*(.*\)\@=/

syn match moonBracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/

