---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
  day_brightness = 0.4,
  dim_inactive = true,
  plugins = { mini_statusline = true },
})

-- auto-dark-modeの初回チェックは非同期のため、VimEnterまでにvim.o.backgroundが
-- セットされずNeovimのTermResponse自動検出が残る。明示的にセットして殺す。
vim.o.background = "dark"
vim.cmd([[:color tokyonight]])

-- tmux paneがunfocusedになったら背景色をずらす (dark→明るく, light→暗く)
-- tmux: `set -g focus-events on` が必要
do
  local group = vim.api.nvim_create_augroup("FocusDim", { clear = true })
  local factor = 0.1 -- 0.0=変化なし, 大きいほど強い

  ---@param color integer
  ---@param lighten boolean trueなら白に寄せる, falseなら黒に寄せる
  ---@return integer
  local function shift(color, lighten)
    local b = color % 256
    local g = math.floor(color / 256) % 256
    local r = math.floor(color / 65536)
    if lighten then
      r = r + math.floor((255 - r) * factor)
      g = g + math.floor((255 - g) * factor)
      b = b + math.floor((255 - b) * factor)
    else
      r = math.floor(r * (1 - factor))
      g = math.floor(g * (1 - factor))
      b = math.floor(b * (1 - factor))
    end
    return r * 65536 + g * 256 + b
  end

  local targets = { "Normal", "NormalNC", "NormalFloat", "SignColumn", "MsgArea" }
  local ns = vim.api.nvim_create_namespace("FocusDim")

  vim.api.nvim_create_autocmd("FocusLost", {
    group = group,
    callback = function()
      local lighten = vim.o.background == "dark"
      for _, name in ipairs(targets) do
        local hl = vim.api.nvim_get_hl(0, { name = name })
        if hl.bg then
          vim.api.nvim_set_hl(ns, name, vim.tbl_extend("force", hl, { bg = shift(hl.bg, lighten) }))
        end
      end
      vim.api.nvim_set_hl_ns(ns)
    end,
  })

  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = function()
      vim.api.nvim_set_hl_ns(0)
    end,
  })
end
