" Vim syntax file
" Language: Ruby
" Maintainer: Nymphium


augroup RubyColor
	autocmd!
	autocmd ColorScheme * hi link rubyBracket Special
	autocmd ColorScheme * hi link rubyCamma Special
	autocmd ColorScheme * hi link rubyKeyword Statement
	autocmd ColorScheme * hi link rubyBlockParameterList Statement
	autocmd ColorScheme * hi link rubyMethodDeclaration Identifier
	autocmd ColorScheme * hi link rubyInstanceVariable Type
	autocmd ColorScheme * hi link rubySymbolName String
	autocmd ColorScheme * hi link rubyColon Statement
	autocmd ColorScheme * hi rubyLambda cterm=bold gui=bold ctermfg=214 guifg=#ffaf87
	autocmd ColorScheme * hi link rubyDefine rubyLambda
	autocmd ColorScheme * hi link rubyEOL String
augroup END


syn match rubyOperator /\s\zs[:?]\ze\s\+/ display
syn match rubyOperator /[\.<>+=\*!%]/ display
syn match rubyOperator "\-" display

syn clear rubySymbol
syn match rubySymbolName /\<\(:\{1}\)\@<=\w\+\>/ display
syn match rubyColon ":" display

syn match rubyLambda /->/ display
syn match rubyCamma "," display

syn clear rubyRegexpDot
syn clear rubyRegexpEscape
syn clear rubyRegexpParens
syn clear rubyRegexpAnchor
syn clear rubyRegexpSpecial
syn clear rubyRegexpComment
syn clear rubyRegexpBrackets
syn clear rubyRegexpCharClass
syn clear rubyRegexpQuantifier
syn clear rubyRegexpSpecial
syn clear rubyRegexp

syn region rubyEOL matchgroup=Statement start="\(<<\)\@<=EOL\s*$" end="^EOL$" contains=rubyInterpolation
syn region rubyEOL matchgroup=Statement start="\(<<-\)\@<=EOL\s*$" end="^\s*EOL$" contains=rubyInterpolation
syn match rubyOperator "/" containedin=NONE display
syn region rubyRegexpComment matchgroup=rubyRegexpSpecial start="(?#" skip="\\)" end=")" contained
syn region rubyRegexpParens matchgroup=rubyRegexpSpecial start="(\(?:\|?<\=[=!]\|?>\|?<[a-z_]\w*>\|?[imx]*-[imx]*:\=\|\%(?#\)\@!\)" skip="\\)" end=")" contained transparent contains=@rubyRegexpSpecial
syn region rubyRegexpBrackets matchgroup=rubyRegexpCharClass start="\[\^\=" skip="\\\]" end="\]" contained transparent contains=rubyStringEscape,rubyRegexpEscape,rubyRegexpCharClass oneline
syn match rubyRegexpCharClass "\\[DdHhSsWw]" contained display
syn match rubyRegexpCharClass "\[:\^\=\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\):\]" contained
syn match rubyRegexpEscape "\\[].*?+^$|\\/(){}[]" contained
syn match rubyRegexpQuantifier "[*?+][?+]\=" contained display
syn match rubyRegexpQuantifier "{\d\+\%(,\d*\)\=}?\=" contained display
syn match rubyRegexpAnchor "[$^]\|\\[ABbGZz]" contained display
syn match rubyRegexpDot "\." contained display
syn match rubyRegexpSpecial "|" contained display
syn match rubyRegexpSpecial "\\[1-9]\d\=\d\@!" contained display
syn match rubyRegexpSpecial "\\k<\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\=>" contained display
syn match rubyRegexpSpecial "\\k'\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\='" contained display
syn match rubyRegexpSpecial "\\g<\%([a-z_]\w*\|-\=\d\+\)>" contained display
syn match rubyRegexpSpecial "\\g'\%([a-z_]\w*\|-\=\d\+\)'" contained display
syn cluster rubyRegexpSpecial contains=rubyInterpolation,rubyNoInterpolation,rubyStringEscape,rubyRegexpSpecial,rubyRegexpEscape,rubyRegexpBrackets,rubyRegexpCharClass,rubyRegexpDot,rubyRegexpQuantifier,rubyRegexpAnchor,rubyRegexpParens,rubyRegexpComment
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="\%(\%(^\|\<\%(and\|or\|while\|until\|unless\|if\|elsif\|when\|not\|then\|else\)\|[;\~=!|&(,[<>?:*+-]\)\s*\)\@<=/" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@rubyRegexpSpecial fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="\%(\h\k*\s\+\)\@<=/[ \t=]\@!" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@rubyRegexpSpecial fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r\z([~`!@#$%^&*_\-+=|\:;"',.? /]\)" end="\z1[iomxneus]*" skip="\\\\\|\\\z1" contains=@rubyRegexpSpecial fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r{" end="}[iomxneus]*" skip="\\\\\|\\}" contains=@rubyRegexpSpecial fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r<" end=">[iomxneus]*" skip="\\\\\|\\>" contains=@rubyRegexpSpecial,rubyNestedAngleBrackets,rubyDelimEscape fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r\[" end="\][iomxneus]*" skip="\\\\\|\\\]" contains=@rubyRegexpSpecial fold
syn region rubyRegexp matchgroup=rubyRegexpDelimiter start="%r(" end=")[iomxneus]*" skip="\\\\\|\\)" contains=@rubyRegexpSpecial fold
