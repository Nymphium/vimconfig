set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:dein = '~/.cache/dein'

if dein#load_state(s:dein)
  call dein#begin(s:dein)

  call dein#add(s:dein . '/repos/github.com/Shougo/dein.vim')

  let s:conf  = $HOME . '/.config/nvim/dein' 
  let s:toml      = s:conf . '/dein.toml'
  let s:lazy_toml = s:conf . '/dein_lazy.toml'
  autocmd VimEnter * call dein#call_hook('post_source')

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

