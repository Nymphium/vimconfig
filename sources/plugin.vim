set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  let s:dein  = $HOME . '/.config/nvim/dein' 
  let s:toml      = s:dein . '/dein.toml'
  let s:lazy_toml = s:dein . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


let g:opamshare = matchstr(substitute(system('opam config var share'), '\([^\n]\+\)\@<=\n.*$', '', ''), '^\(/[^/]\+\)\+/\?')
if !empty(g:opamshare)
  let has_merlin = substitute(system("command -v ocamlmerlin 2>&1 >/dev/null; echo $?"), '\n\+$', '', '')

  if has_merlin == "0"
    execute 'set runtimepath+=' . g:opamshare . '/merlin/vim'
    nnoremap <silent> <ESC> <ESC><ESC>:nohlsearch<CR>:call merlin#StopHighlight()<CR>
  endif

  let has_ocp_indent = substitute(system("command -v ocp-indent 2>&1 >/dev/null; echo $?"), '\n\+$', '', '')
  if has_ocp_indent == "0"
    execute 'set runtimepath^=' . g:opamshare . '/ocp-indent/vim'
    let g:ocp_indent_on = 1

    function! s:ocaml_format()
      if g:ocp_indent_on == 1
        let now_line = line('.')
        exec ':%! ocp-indent'
        exec ':' . now_line
      endif
    endfunction

    augroup OcamlFormat
      autocmd!
      autocmd BufWrite,FileWritePre,FileAppendPre *.mli\= call s:ocaml_format()
    augroup END
  endif
endif

