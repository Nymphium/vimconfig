local ocamllsp = { 'ocamllsp' }
local bashls = { 'bashls' } -- bash-language-server
local tsjs = { 'tsserver', 'typescript-language-server' }

return {
  by_server_name = function(self, server_name)
    for lang, servers in pairs(self) do
      for _, server_name_ in pairs(servers) do
        if server_name == server_name_ then
          return lang
        end
      end
    end
  end,
  lua = { 'lua_ls' }, -- lua-language-server
  vim = { 'vimls' },  -- vim-language-server
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
