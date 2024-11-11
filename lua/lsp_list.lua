-- provides lsp settings in lspconfig name

return {
  nil_ls = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
      flake = { autoEvalInputs = true }
    },
  }
}
