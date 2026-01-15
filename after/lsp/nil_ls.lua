return {
  ["filetypes"] = { "nix" },
  ["rootPatterns"] = { "flake.nix" },
  ["nil"] = {
    ["formatting"] = {
      ["command"] = { "nixfmt" }
    },
    ["flake"] = {
      ["autoEvalInputs"] = true
    }
  }
}
