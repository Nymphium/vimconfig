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
vnoremap <silent> n "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
vnoremap <S-y> "+y
vnoremap <bar> "*y:vim /<C-r>*/ `git ls-files` <bar> cw<CR>

nnoremap <silent> <ESC> <ESC><ESC>:nohlsearch<CR>
nnoremap <ESC>s <ESC>:w!<CR>
nnoremap <ESC>s<ESC>s <ESC>:wq!<CR>
nnoremap <M-s> <ESC>:w!<CR>
nnoremap <M-s><M-s> <ESC>:wq!<CR>
nnoremap <C-q> :bd!<CR>
nnoremap <C-w><C-w> :q!<CR>
nnoremap <Left> <C-w><Left>
nnoremap <Right> <C-w><Right>
nnoremap <Up> <C-w><Up>
nnoremap <Down> <C-w><Down>
nnoremap <M-w> b
nnoremap <M-e> w
nnoremap <BS> X
nnoremap <M-1> <C-x>
nnoremap <M-2> <C-a>
nnoremap j gj
nnoremap k gk
" nnoremap E <Nop>
" nnoremap E w
" nnoremap W <Nop>
" nnoremap W b
nnoremap r <C-r>
nnoremap <C-r> r
" nnoremap <ESC>j <C-d>
" nnoremap <M-j> <C-d>
" nnoremap <ESC>k <C-u>
" nnoremap <M-k> <C-u>
nnoremap <silent> <F4> :setlocal relativenumber!<CR>

nnoremap <silent> cn :cn<CR>
nnoremap <silent> CN :cN<CR>
nnoremap <silent> cq :lcl<CR>

nnoremap w<TAB> <C-w>w
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap wl <ESC><C-w><<C-w><<C-w><<C-w><<C-w><
nnoremap wh <ESC><C-w>><C-w>><C-w>><C-w>><C-w>>
nnoremap wj <ESC><C-w>+<C-w>+<C-w>+<C-w>+<C-w>+
nnoremap wk <ESC><C-w>-<C-w>-<C-w>-<C-w>-<C-w>-

nnoremap <M-o> o<ESC>
nnoremap <S-k> k<S-j>
nnoremap V <C-v>
nnoremap <M-x> "
nnoremap <F6> mq
nnoremap <F7> `q

inoremap <silent> <ESC> <ESC>:nohlsearch<CR>
inoremap <M-v> <C-x><C-r>+
inoremap <M-1> <C-o><C-x>i
inoremap <M-2> <C-o><C-a>i
inoremap <M-p> <C-o>pi
inoremap <ESC>p <C-o>pi
inoremap <M-w> <S-Left>
inoremap <M-e> <S-Right>

cnoremap <ESC>w <S-Left>
cnoremap <M-w> <S-Left>
cnoremap <ESC>e <S-Right>
cnoremap <M-e> <S-Right>
cnoremap <ESC>d <C-w>
cnoremap <M-d> <C-w>
cnoremap <ESC>x <C-r>
cnoremap <M-x> <C-r>
cnoremap w!! w !sudo tee > /dev/null %

tnoremap <ESC> <C-\><C-n>

