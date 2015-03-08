" colorscheme rdark
" `colorscheme` defined at ./plugin.vim #rdark

hi CursorLine cterm=none gui=none ctermbg=237 guibg=#3a3a3a
hi CursorColumn cterm=none gui=none ctermbg=237 guibg=#3a3a3a
hi Comment ctermfg=255 ctermbg=237 guifg=#eeeeee guibg=#3a3a3a
hi SpecialKey ctermfg=240 guifg=#585858
hi LineNr cterm=bold gui=bold ctermfg=246 ctermbg=232 guifg=#949494 guibg=#080808
hi StatusLine cterm=bold gui=bold ctermfg=0 ctermbg=255 guifg=#000000 guibg=#eeeeee
hi Special cterm=bold gui=bold ctermfg=204 guifg=#ff5f87
hi PreProc cterm=bold gui=bold
hi Type cterm=bold gui=bold ctermfg=47 guifg=#00ff5f
hi Statement cterm=bold gui=bold
hi Constant cterm=bold gui=bold
hi Shebang cterm=bold,italic gui=bold,italic ctermfg=126 guibg=#af00af guifg=black
hi Normal ctermfg=46 ctermbg=NONE guifg=#1fff40 guibg=#000000
hi Identifier term=underline cterm=bold gui=bold ctermfg=14 guifg=#00ffff
hi Constant term=underline cterm=bold gui=bold ctermfg=13 guifg=#ff4fff

augroup ShebangHighLight
	autocmd!
	autocmd VimEnter * syn match Shebang /^#!\/.\{-\}bin.*$/
augroup END

