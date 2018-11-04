" Vim syntax file
" Language: MoonScript
" Maintainer: Nymphium
"
" It's assuming to use leafo/moonscrpt-vim(https://github.com/leafo/moonscript-vim)


augroup MoonColor
	autocmd!
	autocmd ColorScheme * hi moonFunction cterm=bold gui=bold ctermfg=214 guifg=#ffaf87
	autocmd ColorScheme * hi moonChar cterm=bold gui=bold
	autocmd ColorScheme * hi moonMetatable cterm=bold gui=bold
	autocmd ColorScheme * hi moonObjAssign cterm=bold gui=bold
	autocmd ColorScheme * hi moonLength cterm=bold gui=bold ctermfg=62 guifg=#5f5fd7
	autocmd ColorScheme * hi moonTable cterm=bold gui=bold
	autocmd ColorScheme * hi link moonInterpDelim Special
	autocmd ColorScheme * hi link moonKeyword Statement
	autocmd ColorScheme * hi link moonBracket Special
	autocmd ColorScheme * hi link moonConditional Type
	autocmd ColorScheme * hi link moonGlobal Boolean
	autocmd ColorScheme * hi link moonRoundBrac Special
	autocmd ColorScheme * hi link moonTable Special
	autocmd ColorScheme * hi link moonSquareBrac Special
	autocmd ColorScheme * hi link moonBlockString String
augroup END

syn clear moonShortHandAssign
syn clear moonObjAssign
syn clear moonDotAccess
syn clear moonFunction

syn match moonChar /[~=%<>/+\*,\.]\|\(\-\)\@<!\-\(\-\|>\)\@!/ contained display

syn match moonKeyword ":"

syn match moonObjAssign /\<[_a-zA-Z]\w\{-}\>\(:\s*\(\((.\{-\})\)\?-\|=>\)\?\)\@=/ display
syn match moonObjAssign /\(\s\+:\)\@<=\<[a-zA-Z]\w\{-}\>/ display

syn match moonLength /#\(@\?[@_a-zA-Z]\w\{-}[\.:]\?\)\+/ display
syn match moonLength /#{\(.\{-}\)\@=}/ display
syn region moonTableLength matchgroup=moonLength start="#{" end="}" display transparent oneline containedin=moonString,moonString2,moonBasic
syn region moonInterp matchgroup=moonInterpDelim start=/#{/ end=/}/ contained
\                       contains=@moonAll


syn match moonTable /\zs\<[_a-zA-Z]\w\{-}\>\ze\.\(\.\)\@!/ display
syn match moonTable /\zs\<[_a-zA-Z]\w\{-}\>\ze\(\[\)\@=/ display
syn match moonTable /\zs\<[_a-zA-Z]\w\{-}\>\ze\(\\\)\@=/ display

syn match moonOperator "\~=" contains=NONE display
syn match moonOperator "!=" contains=NONE display

syn match moonFunction /->\|=>/ display
syn match moonFunction /\\\(\<[_a-zA-Z]\w\{-}\>\)\@=/ display

syn match moonLuaFunc /\<[_a-zA-Z]\w*\>\(\s*\s*(\)\@=/ display contains=ALLBUT,Normal
syn match moonLuaFunc /\<[_a-zA-Z]\w*\>\(\(:\|\(\s*=\)\)\(\s\{-}(\(\w\|,\|\s\|\.\)\{-})\)\?\s\{-}\(=\|-\)>\)\@=/ display
syn match moonLuaFunc /@\?[_a-zA-Z]\w\{-}\(\s*!\(!\{1}\)\@!\)\@=/ display
syn match moonLuaFunc /\(\\\)\@<=\<[_a-zA-Z]\w\{-}\>/ display

syn clear Bracket
syn match moonBracket /[(){}]\|\[\|\]/ containedin=moonString,moonString2,moonBasic

" syn region moonBlockString start="\[\z(=+\)\[" end="\]\z1\]" contains=@Spell

syn match moonMetatable  /\<__\(index\|newindex\|mode\|call\|metatable\|tostring\|len\|gc\|unm\|add\|sub\|mul\|div\|modd|pow\|concat\|eq\|lt\|gt\|class\|name\|inherited\)\>/ display
" syn region moonParen transparent  matchgroup=moonRoundBrac start='(' end=')' contains=ALLBUT,luaParenError,luaTodo,luaSpecial,luaIfThen,luaElseifThen,luaElse,luaThenEnd,luaBlock,luaLoopBlock,luaIn,luaStatement
syn region moonIndexing transparent  matchgroup=moonSquareBrac start=/\(=\|\[\)\@<!\[\(=\|\[\)\@!/ end=/\(=\|\]\)\@<!\]\(=\|\]\)\@!/ contains=ALLBUT,luaParenError,luaTodo,luaSpecial,luaIfThen,luaElseifThen,luaElse,luaThenEnd,luaBlock,luaLoopBlock,luaIn,luaStatement
