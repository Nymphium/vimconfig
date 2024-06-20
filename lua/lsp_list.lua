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
      analyses = {
        nilness = true,
      },
      hints = {
        assignVariableTypes = true,
      }
    }
  }
}
