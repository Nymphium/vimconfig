return {
  lua_ls = {
    Lua = {
      hint = { enable = true }
    }
  },
  gopls = {
    gopls = {
      codelenses = {
        gc_detials = true,
      },
      usePlaceholders = true,
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
      }
    }
  },
  jsonnet_ls = {
    formatting = {
      CommentStyle = 'hash',
    }
  },
}
