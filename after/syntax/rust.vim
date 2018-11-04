" Vim syntax file
" Language: Rust
" Maintainer: Nymhpium

hi link rustUse Operator
hi link rustLet Operator
hi link rustNew Operator
hi link rustDot Operator
hi link rustSingleColon Operator
hi link rustKeyword Operator
hi link rustFunc Identifier
hi link rustShebang Shebang
hi link rustCamma Special
hi link rustBracket Special
" hi link rustConditional
hi rustConditional cterm=bold gui=bold ctermfg=48 guifg=#00ff87
hi rustFn cterm=bold gui=bold ctermfg=214 guifg=#ffaf00

syn keyword rustUse use
syn keyword rustFn fn
syn keyword rustLet let
syn keyword rustNew new
syn match rustCamma "," display
syn match rustSingleColon /\(:\)\@<!:\(:\)\@!/ display
syn match rustFunc /\<\w\+\>\(\s*(\)\@=/ display
syn match rustDot "\." display
syn clear rustConditional
syn keyword rustConditional if
syn keyword rustConditional else
syn keyword rustKeyword match
syn match rustBracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/ contains=rustBracket
" syn keyword rustConditional
