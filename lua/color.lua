---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
  day_brightness = 0.4,
  dim_inactive = true,
  plugins = { mini_statusline = true },
})

vim.cmd([[:color tokyonight]])
