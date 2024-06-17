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
        unusedparams = true,
        unreachable = true,
        nilness = true,
        shadow = true,
      },
      hints = {
        assignVariableTypes = true,
        parameterNames = true,
      }
    }
  }
}
