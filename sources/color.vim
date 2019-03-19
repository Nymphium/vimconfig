" colorscheme rdark
" `colorscheme` defined at ./plugin.vim #rdark

function! s:color()
	hi MoreFunction cterm=bold gui=bold ctermfg=214 guifg=#ffaf87
	hi CursorLine cterm=none gui=none ctermbg=237 guibg=#3a3a3a
	hi CursorColumn cterm=none gui=none ctermbg=237 guibg=#3a3a3a
	hi Comment cterm=italic gui=italic ctermfg=255 ctermbg=237 guifg=#eeeeee guibg=#3a3a3a
	hi SpecialKey cterm=bold gui=none ctermfg=240 guifg=#585858
	hi LineNr cterm=bold gui=bold ctermfg=246 ctermbg=232 guifg=#949494 guibg=#080808
	hi StatusLine cterm=bold gui=bold ctermfg=0 ctermbg=255 guifg=#000000 guibg=#eeeeee
	hi Special cterm=bold gui=bold ctermfg=204 guifg=#ff5f87
	hi PreProc cterm=bold gui=bold
	hi Keyword cterm=bold gui=bold guifg=#eeeeec
	hi Type cterm=bold gui=bold ctermfg=47 guifg=#00ff5f
	hi Statement cterm=bold gui=bold
	hi Constant cterm=bold gui=bold
	hi Shebang cterm=bold,italic gui=bold,italic ctermbg=126 ctermfg=0 guibg=#af00af guifg=black
	hi link Bracket Special
	hi DiffAdd    cterm=bold ctermbg=22
	hi DiffDelete cterm=bold ctermbg=52
	hi DiffChange cterm=bold ctermbg=17
	hi DiffText   cterm=bold ctermbg=21
	hi Pmenu ctermbg=0 cterm=none ctermfg=white
	hi PmenuSel ctermbg=4 cterm=bold ctermfg=white
	hi PmenuSbar ctermbg=2
	hi PmenuThumb ctermfg=3 cterm=bold ctermfg=white
	hi NonText ctermfg=12 guifg=#339fff guibg=NONE
	hi Visual ctermbg=242 guibg=gray
	hi SignColumn ctermbg=016 guibg=#000000
	hi link Typedef Statement
	hi link GitConflictMarker Error
	hi link GitConflictMarkerEq GitConflictMarker
	hi link GitConflictCommit QuickFixLine
	hi GitConflictMerge ctermbg=blue guibg=blue
	hi link GitConflictMergeThemselves GitConflictMerge
	hi link GitConflictMergeOurselves GitConflictMerge
endfunction

function! s:syn()
	syn match Shebang /^#!\/.\{-\}bin\/.*$/

endfunction

function! s:syn_ft()
	syn match GitConflictCommit /\(^\(<\{7}\|>\{7}\)\s\+\)\@<=\(.*\)$/
	syn match GitConflictMarkerEq /^=======$/
	syn region GitConflictMergeOurselves matchgroup=GitConflictMarker start=/^<<<<<<< \@=/ end=/^=======$/ contains=NONEBUT,GitConflictCommit
	syn region GitConflictMergeThemselves matchgroup=GitConflictMarker start=/^=======$/ end=/^>>>>>>> \@=/ contains=NONEBUT,GitConflictCommit
	syn region GitConflictMerge matchgroup=GitConflictMarker start=/^<<<<<<< \@=/ end=/^>>>>>>> \@=/ contains=NONEBUT,GitConflictCommit,GitConflictMarkerEq
endfunction

augroup MyHighlighten
	autocmd!
	autocmd ColorScheme * call s:color()
	autocmd ColorScheme,BufNew,BufWrite *
		\ call s:syn()
		\| if IsGitConflict()
		\|   call s:syn_ft()
		\| endif
	" autocmd StdinReadPost,BufAdd,BufEnter,BufNew,FileType * syn match Bracket /[(){}]\|\[\(\[\)\@!\|\]\(\]\)\@!/ contains=Bracket
augroup END

