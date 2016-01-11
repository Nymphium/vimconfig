vnoremap <silent> <ESC> <C-c>:nohlsearch<CR>
vnoremap v $h
vnoremap <ESC>w b
vnoremap <M-w> b
vnoremap <ESC>e <Nop>
vnoremap <ESC>e e
vnoremap <M-e> <Nop>
vnoremap <M-e> e
vnoremap <TAB> >
vnoremap <S-Tab> <
vnoremap <silent> n "*y/<C-r>*<CR>
vnoremap <S-y> "+y

nnoremap <silent> <ESC> <ESC><ESC>:nohlsearch<CR>
nnoremap <ESC>s <ESC>:w!<CR>
nnoremap <ESC>s<ESC>s <ESC>:wq!<CR>
nnoremap <M-s> <ESC>:w!<CR>
nnoremap <M-s><M-s> <ESC>:wq!<CR>
" nnoremap <ESC>w<ESC>w <ESC>:q!<CR>
" nnoremap <M-w><M-w> <ESC>:q!<CR>
nnoremap <C-w> <Nop>
nnoremap <C-w><C-w> :q!<CR>
nnoremap <ESC>w b
nnoremap <M-w> b
nnoremap <ESC>e w
nnoremap <M-e> w
nnoremap <BS> X
nnoremap <ESC>1 <C-x>
nnoremap <M-1> <C-x>
nnoremap <ESC>2 <C-a>
nnoremap <M-2> <C-a>
nnoremap j gj
nnoremap k gk
" nnoremap E <Nop>
" nnoremap E w
" nnoremap W <Nop>
" nnoremap W b
nnoremap r <C-r>
" nnoremap <ESC>j <C-d>
" nnoremap <M-j> <C-d>
" nnoremap <ESC>k <C-u>
" nnoremap <M-k> <C-u>
nnoremap <silent> <F3> :setlocal relativenumber!<CR>
nnoremap I <Nop>
" if &ft == "rust"
	" nnoremap <silent> II :RustFmt
" els
	nnoremap <silent> II :let l=line(".")<CR>:let c=col(".")<CR><ESC>gg=G:call cursor(l,c)<CR>:unlet l<CR>:unlet c<CR>
" endif
augroup RustFmt
	autocmd!
	autocmd Filetype rust nnoremap <silent> II :RustFmt<CR>
augroup END

nnoremap ww <ESC>:vne<Space>
nnoremap wv <ESC>:new<Space>
nnoremap w<TAB> <C-w>w
nnoremap wl <ESC><C-w><<C-w><<C-w><<C-w><<C-w><
nnoremap wh <ESC><C-w>><C-w>><C-w>><C-w>><C-w>>
nnoremap wj <ESC><C-w>+<C-w>+<C-w>+<C-w>+<C-w>+
nnoremap wk <ESC><C-w>-<C-w>-<C-w>-<C-w>-<C-w>-
nnoremap <return> <ESC>i<return><ESC>
nnoremap <TAB> >>
nnoremap <S-Tab> <<
nnoremap <ESC>o <Nop>
nnoremap <ESC>o o<ESC>
nnoremap <M-o> <Nop>
nnoremap <M-o> o<ESC>
nnoremap wo :new<Space><cfile><CR>
nnoremap wO :new<Space><cfile><CR><C-w>b:q!<CR>
nnoremap <S-k> k<S-j>
nnoremap <silent> <F11> <ESC>:Q<CR>
nnoremap V <C-v>
nnoremap Q <Nop>
nnoremap <ESC>d de
nnoremap <M-d> de
nnoremap <ESC><S-d> dbx
nnoremap <M-D> dbx
nnoremap <ESC>x "
nnoremap <M-x> "

" tag jump
function TagUpdateOrTagJump()
	if strlen(findfile("tags")) < 1
		TagUpdate
	endif

	exe('tjump ' .expand("<cword>"))
endfunction
nnoremap tn :call TagUpdateOrTagJump()<CR>
nnoremap tt <C-t>

inoremap <silent> <ESC> <C-c>:nohlsearch<CR>
inoremap <ESC>v <Nop>
inoremap <ESC>v <C-x><C-r>+
inoremap <M-v> <Nop>
inoremap <M-v> <C-x><C-r>+
inoremap <ESC>1 <ESC><C-x>i
inoremap <M-1> <ESC><C-x>i
inoremap <ESC>2 <ESC><C-a>i
inoremap <M-2> <ESC><C-a>i
inoremap <M-p> <ESC>pi
inoremap <ESC>p <ESC>pi
inoremap <ESC>d <ESC>ddi
inoremap <ESC>w <S-Left>
inoremap <M-w> <S-Left>
inoremap <ESC>e <S-Right>
inoremap <M-e> <S-Right>
inoremap <C-q> <ESC>:q!<CR>
inoremap <F3> <ESC><ESC>:setlocal relativenumber!<CR>a
inoremap <ESC>D <C-W>
inoremap <M-D> <C-W>
inoremap <ESC>d <S-Right><C-W>
inoremap <M-d> <S-Right><C-W>
inoremap <ESC>x <Nop>
inoremap <M-x> <Nop>
inoremap <ESC>x <C-x><C-r>
inoremap <M-x> <C-x><C-r>
inoremap <ESC>o <C-o>o
inoremap <ESC>O <C-o>O
inoremap <M-o> <C-o>o
inoremap <M-O> <C-o>O

cnoremap <ESC>w <Nop>
cnoremap <M-w> <Nop>
cnoremap <ESC>w <S-Left>
cnoremap <M-w> <S-Left>
cnoremap <ESC>e <Nop>
cnoremap <M-e> <Nop>
cnoremap <ESC>e <S-Right>
cnoremap <M-e> <S-Right>
cnoremap <ESC>d <Nop>
cnoremap <M-d> <Nop>
cnoremap <ESC>d <C-w>
cnoremap <M-d> <C-w>
cnoremap <ESC>x <C-r>
cnoremap <M-x> <C-r>

map <silent> <C-+> :call FontSizePlus()<CR>
map <silent> <C-*> :call FontSizeMinus()<CR>

