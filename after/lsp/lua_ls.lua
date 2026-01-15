return {
  Lua = {
    hint = {
      enable    = true,
      paramType = true
    },
    codelens = { enable = true },
    diagnostics = {
      enable = true,
      disable = { "redefined-local" }
    },
  }
}
