return {
  typescript = {
    tsserver = {
      experimental = {
        enableProjectDiagnostics = true
      },
    },
    preferences = {
      includeInlayVariableTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    },
    inlayHints = {
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
    },
    implementationsCodeLens = {
      enabled = true,
    },
  },
  completions = {
    completeFunctionCalls = true,
  },
  -- ["typescript.tsserver.experimental.enableProjectDiagnostics"] = true,
  -- ["typescript.preferences.includeInlayVariableTypeHints"] = true,
  -- ["typescript.preferences.includeInlayFunctionParameterTypeHints"] = true,
  -- ["typescript.preferences.includeInlayPropertyDeclarationTypeHints"] = true,
  -- ["typescript.preferences.includeInlayParameterNameHints"] = "all",
  -- ["typescript.preferences.includeInlayParameterNameHintsWhenArgumentMatchesName"] = true,
  -- ["typescript.inlayHints.includeInlayFunctionParameterTypeHints"] = true,
  -- ["typescript.inlayHints.includeInlayVariableTypeHints"] = true,
  -- ["typescript.implementationsCodeLens.enabled"] = true,
  -- ["completions.completeFunctionCalls"] = true
}
