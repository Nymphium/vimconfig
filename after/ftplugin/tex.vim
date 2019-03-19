setlocal ft=tex
let g:tex_flavor = "latex"
let g:java_highlight_all = 1
let g:java_highlight_debug = 1
let g:java_highlight_functions = 1
silent setlocal expandtab
setlocal foldmarker=[[[,]]]

augroup LaTeXEnv
  autocmd!
  autocmd BufWritePre *.tex silent :%s/｡/。/ge
  autocmd BufWritePre *.tex silent :%s/､/、/ge
  autocmd BufWritePre *.tex silent :%s/｢/「/ge
  autocmd BufWritePre *.tex silent :%s/｣/」/ge
augroup END
