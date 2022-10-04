local ocamllsp = { 'ocamllsp' }
local bashls = { 'bashls' } -- bash-language-server

return {
  lua = { 'sumneko_lua' }, -- lua-language-server
  vim = { 'vimls' }, -- vim-language-server
  ocaml = ocamllsp,
  dune = ocamllsp,
  typescript = { 'tsserver' },
  sh = bashls,
  bash = bashls,
  zsh = bashls,
  haskell = { 'hls' },
  tex = { 'texlab' }
}
