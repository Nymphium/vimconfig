" colorscheme rdark
" `colorscheme` defined at ./plugin.vim #rdark

hi CursorLine cterm=none gui=none ctermbg=237 guibg=#3a3a3a
hi CursorColumn cterm=none gui=none ctermbg=237 guibg=#3a3a3a
hi Comment cterm=italic gui=italic ctermfg=255 ctermbg=237 guifg=#eeeeee guibg=#3a3a3a
hi SpecialKey cterm=bold gui=none ctermfg=240 guifg=#585858
hi LineNr cterm=bold gui=bold ctermfg=246 ctermbg=232 guifg=#949494 guibg=#080808
hi StatusLine cterm=bold gui=bold ctermfg=0 ctermbg=255 guifg=#000000 guibg=#eeeeee
hi Special cterm=bold gui=bold ctermfg=204 guifg=#ff5f87
hi PreProc cterm=bold gui=bold
hi Type cterm=bold gui=bold ctermfg=47 guifg=#00ff5f
hi Statement cterm=bold gui=bold
hi Constant cterm=bold gui=bold
hi Shebang cterm=bold,italic gui=bold,italic ctermbg=126 ctermfg=0 guibg=#af00af guifg=black
hi link Bracket Special

" hi Normal ctermfg=46 ctermbg=NONE guifg=#1fff40 guibg=#000000
" hi Identifier term=underline cterm=bold gui=bold ctermfg=14 guifg=#00ffff
" hi Constant term=underline cterm=bold gui=bold ctermfg=13 guifg=#ff4fff

augroup MyHighlighten
	autocmd!
	autocmd VimResized * :redraw!
	autocmd Syntax,FileType * syn match Shebang /^#!\/.\{-\}bin\/.*$/
	autocmd Syntax * syn match Bracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/ contains=Bracket display
augroup END

