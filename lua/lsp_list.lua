local ocamllsp = { 'ocamllsp' }
local bashls = { 'bashls' } -- bash-language-server
local tsjs = { 'tsserver', 'typescript-language-server' }

return {
  lua = { 'lua_ls' }, -- lua-language-server
  vim = { 'vimls' },  -- vim-language-server
  ruby = { 'solargraph'},
  ocaml = ocamllsp,
  dune = ocamllsp,
  typescript = tsjs,
  javascript = tsjs,
  sh = bashls,
  bash = bashls,
  zsh = bashls,
  haskell = { 'hls' },
  tex = { 'texlab' }
}
