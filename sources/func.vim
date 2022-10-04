scriptencoding utf-8

" go to where the file is located {{{
command Here cd %:p:h
" " }}}

" " go to window {{{
command! -nargs=1 GoWin lua vim.api.nvim_set_current_win(<args>)
" " }}}

"" highlight Zenkaku-space {{{
  hi ZenkakuSpace cterm=underline ctermbg=196 gui=underline guifg=darkgrey

  augroup ZenkakuSpaceHighlight
    autocmd!
    autocmd BufReadPost,FileReadPost * match ZenkakuSpace /　/
  augroup END
"" }}}

"" set-shellscript filetype {{{
  function! DetectFromShebang()
    if strlen(&ft) > 1
      return
    endif

    let s:l = line('.')
    let s:c = col('.')
    call cursor(1, 1)
    let s:line = getline('.')
    let s:this_ft = matchstr(s:line, '\(^#!.\{-}\/bin\/.\{-}\)\@<=\w\+$')

    if strlen(s:this_ft) > 0
      if s:this_ft ==# 'bash' || s:this_ft ==# 'zsh'
        let s:this_ft = 'sh'
      endif

      let s:this_ft = 'set ft=' . s:this_ft

      execute (s:this_ft)
    endif

    call cursor(s:l, s:c)
  endfunction

  if strlen(&ft) < 1
    augroup DetectFromShebangAndHighlightAgain
      autocmd!
      autocmd BufWritePost * call DetectFromShebang()
      autocmd BufWritePost * syn match Shebang /^#!\/.\{-\}bin\/.*$/
    augroup END
  endif
"" }}}

" ""  tag command{{{
  " command! TagUpdateAll call system("ctags --languages=" . &filetype .  " --sort=foldcase -R .")
  " command! TagUpdate call system("ctags --languages=" . &filetype .  " " . expand("%.p"))
  " command! RemoveTag call system("rm tags")
" "" }}}

" "" racket lang setup {{{
  " augroup RacketSetup
    " autocmd!
    " au BufReadPost *.rkt,*.rktl set filetype=racket
    " au filetype racket set lisp
    " au filetype racket set expandtab
    " au filetype racket set softtabstop=2
    " au filetype racket let g:syntastic_enable_racket_racket_checker=1
    " au filetype racket set lispwords+=public-method,override-method,private-method,syntax-case,syntax-rules
  " augroup END
" "" }}}

" augroup Terminal
  " autocmd!
  " autocmd WinEnter *
        " \  if &buftype ==# 'terminal' && bufname(bufnr('%')) =~# '\<ocaml\>'
        " \|   setlocal ft=ocaml
        " \| endif
" augroup END
function! Dirof()
  return expand('%:p:h')
endfunction

command! Dirof echo Dirof()

" "augroup VimSession
  " "autocmd!
  " "autocmd VimEnter *
    " "\| let s:sessionfile = Dirof () . '/Session.vim'
    " "\| if filereadable(s:sessionfile)
    " "\|   execute('session ' . s:sessionfile)
    " "\| endif
  " "autocmd VimLeave * mksession!
" "augroup END

function! LineAppend(str)
  return setline(line('.'), getline('.') . a:str)
endfunction

function! IsGitConflict()
  return system('git diff --name-only --diff-filter=U 2>/dev/null | wc') != '0'
endfunction

