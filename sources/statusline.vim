" based on https://gist.github.com/meskarune/57b613907ebd1df67eb7bdb83c6e6641

" Status Line Custom
let g:currentmode={
    \ 'n' : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

set statusline=
set statusline+=%0*\ B%n\ W%{win_getid()}\  " buffer window
set statusline+=%1*\ %t%{&ft!=''?'['.&ft.']':''}%m\  " filename[modified?]
set statusline+=%2*\ %{toupper(&fenc!=''?&fenc:&enc)}\  " file encoding
set statusline+=%0*\ %=
set statusline+=%2*\ %{ModeCurrent()}\ 
set statusline+=%0*\ %h%wLine\ %l\/%L\ Col\ %v\  " (current linenenumber)/(all linenumber) (nth character)
set laststatus=2
