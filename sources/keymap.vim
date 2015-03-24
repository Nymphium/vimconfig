vnoremap <silent> <ESC> <C-c>:nohlsearch<CR>
vnoremap v $h
vnoremap L <Nop>
vnoremap H <Nop>
vnoremap W b
vnoremap E <Nop>
vnoremap E e
vnoremap <ESC>L $
vnoremap <ESC>H ^
vnoremap <ESC>j <C-d>
vnoremap <ESC>k <C-u>
vnoremap <TAB> >
vnoremap <S-Tab> <
vnoremap <silent> n "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
vnoremap <S-y> "+y

nnoremap <silent> <ESC> <ESC><ESC>:nohlsearch<CR>
nnoremap <ESC>a <ESC>:saveas 
nnoremap <ESC>s <ESC>:w!<CR>
nnoremap <ESC>s<ESC>s <ESC>:wq!<CR>
nnoremap <ESC>w<ESC>w <ESC>:q!<CR>
nnoremap <BS> X
nnoremap <ESC>1 <C-x>
nnoremap <ESC>2 <C-a>
nnoremap j gj
nnoremap k gk
nnoremap E <Nop>
nnoremap E w
nnoremap W <Nop>
nnoremap W b
nnoremap r <C-r>
nnoremap <ESC>j <C-d>
nnoremap <ESC>k <C-u>
nnoremap <silent> <F3> :setlocal relativenumber!<CR>
nnoremap I <Nop>
nnoremap <silent> II :let l=line(".")<CR>:let c=col(".")<CR><ESC>gg=G:call cursor(l,c)<CR>:unlet l<CR>:unlet c<CR>
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
nnoremap wo :new<Space><cfile><CR>
nnoremap <S-k> k<S-j>
nnoremap <silent> <F11> <ESC>:Q<CR>
nnoremap V <C-v>
nnoremap Q <Nop>
nnoremap ; a;<ESC><ESC>

inoremap <silent> <ESC> <C-c>:nohlsearch<CR>
inoremap <ESC>v <Nop>
inoremap <ESC>v <ESC>"*pa
inoremap <ESC>1 <Nop>
inoremap <ESC>2 <Nop>
inoremap <ESC>1 <ESC><C-x>i
inoremap <ESC>2 <ESC><C-a>i
inoremap <ESC>p <ESC>pi
inoremap <ESC>d <ESC>ddi
inoremap <ESC>w <S-Left>
inoremap <ESC>e <S-Right>
inoremap <C-q> <ESC>:q!<CR>
inoremap <F3> <ESC><ESC>:setlocal relativenumber!<CR>a
inoremap <ESC>D <C-W>
inoremap <ESC>d <S-Right><C-W>


vnoremap <M-L> $
vnoremap <M-H> ^
vnoremap <M-j> <C-d>
vnoremap <M-k> <C-u>

nnoremap <M-a> <ESC>:saveas 
nnoremap <M-s> <ESC>:w!<CR>
nnoremap <M-s>><M-s> <ESC>:wq!<CR>
nnoremap <M-w><M-w> <ESC>:q!<CR>
nnoremap <M-1> <C-x>
nnoremap <M-2> <C-a>
nnoremap <M-j> <C-d>
nnoremap <M-k> <C-u>
nnoremap <M-o> <Nop>
nnoremap <M-o> o<ESC>

inoremap <M-v> <Nop>
inoremap <M-v> <ESC>"*pa
inoremap <M-1> <Nop>
inoremap <M-2> <Nop>
inoremap <M-1> <ESC><C-x>i
inoremap <M-2> <ESC><C-a>i
inoremap <M-p> <ESC>pi
inoremap <M-d> <ESC>ddi
inoremap <M-w> <S-Left>
inoremap <M-e> <S-Right>
inoremap <M-D> <C-W>
inoremap <M-d> <S-Right><C-W>

