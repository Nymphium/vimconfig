" colorscheme rdark
" `colorscheme` defined at ./plugin.vim #rdark

augroup MyHighlighten
	autocmd!
	autocmd ColorScheme * hi CursorLine cterm=none gui=none ctermbg=237 guibg=#3a3a3a
	autocmd ColorScheme * hi CursorColumn cterm=none gui=none ctermbg=237 guibg=#3a3a3a
	autocmd ColorScheme * hi Comment cterm=italic gui=italic ctermfg=255 ctermbg=237 guifg=#eeeeee guibg=#3a3a3a
	autocmd ColorScheme * hi SpecialKey cterm=bold gui=none ctermfg=240 guifg=#585858
	autocmd ColorScheme * hi LineNr cterm=bold gui=bold ctermfg=246 ctermbg=232 guifg=#949494 guibg=#080808
	autocmd ColorScheme * hi StatusLine cterm=bold gui=bold ctermfg=0 ctermbg=255 guifg=#000000 guibg=#eeeeee
	autocmd ColorScheme * hi Special cterm=bold gui=bold ctermfg=204 guifg=#ff5f87
	autocmd ColorScheme * hi PreProc cterm=bold gui=bold
	autocmd ColorScheme * hi Keyword cterm=bold gui=bold guifg=#eeeeec
	autocmd ColorScheme * hi Type cterm=bold gui=bold ctermfg=47 guifg=#00ff5f
	autocmd ColorScheme * hi Statement cterm=bold gui=bold
	autocmd ColorScheme * hi Constant cterm=bold gui=bold
	autocmd ColorScheme * hi Shebang cterm=bold,italic gui=bold,italic ctermbg=126 ctermfg=0 guibg=#af00af guifg=black
	autocmd ColorScheme * hi link Bracket Special
	autocmd ColorScheme * hi DiffAdd    cterm=bold ctermbg=22
	autocmd ColorScheme * hi DiffDelete cterm=bold ctermbg=52
	autocmd ColorScheme * hi DiffChange cterm=bold ctermbg=17
	autocmd ColorScheme * hi DiffText   cterm=bold ctermbg=21
	autocmd ColorScheme * hi Pmenu ctermbg=0 cterm=none ctermfg=white
	autocmd ColorScheme * hi PmenuSel ctermbg=4 cterm=bold ctermfg=white
	autocmd ColorScheme * hi PmenuSbar ctermbg=2
	autocmd ColorScheme * hi PmenuThumb ctermfg=3 cterm=bold ctermfg=white
	autocmd ColorScheme * hi NonText ctermfg=12 guifg=#339fff guibg=none

	autocmd Syntax,FileType * syn match Shebang /^#!\/.\{-\}bin\/.*$/
	" autocmd StdinReadPost,BufAdd,BufEnter,BufNew,FileType * syn match Bracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/ contains=Bracket
augroup END

