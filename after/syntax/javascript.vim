function! s:color()
  hi link javascriptBraces Bracket
  hi link javascriptClassKeyword Conditional
  hi link javascriptConstructor Conditional
endfunction

augroup JSColor
  autocmd!
  autocmd BufEnter *.js,*.jsx call s:color()
  autocmd FileType javascript call s:color()
augroup END

" syn match jsBrac /(\|)\|{\|}\|\[\|\]/
