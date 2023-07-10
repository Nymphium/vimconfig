local packer_bootstrap
do -- {{{
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
      install_path })
    vim.cmd [[packadd packer.nvim]]
  end
end -- }}}


require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup({
        transparent = true,
        on_highlights = function(hl)
          hl.LineNr = hl.Normal
          hl.StatusLine = hl.MiniStatuslineModeNormal
          hl.User1 = hl.MiniStatuslineFilename
          hl.User2 = hl.MiniStatuslineDevinfo
          hl.User3 = hl.MiniStatuslineDevinfo
        end
      })

      vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        pattern = { "*" },
        callback = function()
          vim.api.nvim_set_hl(0, 'StatusLine', { link = 'MiniStatuslineModeInsert' })
        end
      })

      vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
        pattern = { "*:[vV\x16]" },
        callback = function()
          vim.api.nvim_set_hl(0, 'StatusLine', { link = 'MiniStatuslineModeVisual' })
        end
      })

      vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
        pattern = { "*:c" },
        callback = function(ev)
          vim.api.nvim_set_hl(0, 'StatusLine', { link = 'MiniStatuslineModeCommand' })
        end
      })

      vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
        pattern = { "*:r" },
        callback = function()
          vim.api.nvim_set_hl(0, 'StatusLine', { link = 'MiniStatuslineModeReplace' })
        end
      })

      vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
        pattern = { "*:n" },
        callback = function(ev)
          vim.api.nvim_set_hl(0, 'StatusLine', { link = 'MiniStatuslineModeNormal' })
        end
      })

      vim.cmd [[:color tokyonight]]
    end
  }

  use { 'scrooloose/nerdcommenter', -- {{{
    config = function()
      vim.cmd [[let NERDSpaceDelims = 1]]
      vim.api.nvim_set_keymap('n', '<M-C>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<M-C>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
    end
  }                                        -- }}}

  use { 'nvim-treesitter/nvim-treesitter', -- {{{
    run = ':TSUpdate',
    config = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "typescript", "haskell", "ocaml", "bash", "lua", "vim" },
        auto_install = true,
        endwise = { enable = true }, -- for treesitter-endwise
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
      }
    end
  } -- }}}

  use 'nvim-treesitter/nvim-treesitter-context'

  -- nvim-lsp {{{
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use { 'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end
  }

  use 'tamago324/nlsp-settings.nvim'

  use { 'j-hui/fidget.nvim',
    config = function()
      require "fidget".setup {}
    end
  }

  -- completions {{{
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'ray-x/cmp-treesitter'
  use 'onsails/lspkind.nvim'

  -- use { 'github/copilot.vim',
  -- config = function()
  -- vim.cmd([[:let g:copilot_enabled = v:true]])
  -- end
  -- }
  use { "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = { ["*"] = true }
      })
      vim.keymap.set("i", "<C-Tab>", "<cmd>Copilot suggestion<CR>", { noremap = true, silent = true })
    end,
  }
  use { 'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua', 'nvim-cmp' },
    config = function()
      require('copilot_cmp').setup({
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing
        },
      })
    end
  }
  -- }}}

  use 'RRethy/vim-illuminate'
  use 'folke/lsp-colors.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'lukas-reineke/lsp-format.nvim'
  -- use { "ErichDonGubler/lsp_lines.nvim", -- {{{
  -- config = function()
  -- require("lsp_lines").setup()

  -- vim.diagnostic.config({
  -- virtual_text = false,
  -- })
  -- end,
  -- } -- }}}
  -- }}}

  use { 'Shougo/echodoc.vim',
    config = function()
      vim.cmd([[:let g:echodoc_enable_at_startup = 1]])
      vim.cmd([[:let g:echodoc#type = "popup"]])
    end
  }
  use 'tpope/vim-sleuth'

  use { 'tpope/vim-surround', -- {{{
    config = function()
      vim.cmd [=[xmap " <Plug>VSurround"]=]
      vim.cmd [=[xmap ' <Plug>VSurround']=]
      vim.cmd [=[xmap ( <Plug>VSurround)]=]
      vim.cmd [=[xmap [ <Plug>VSurround]]=]
      vim.cmd [=[xmap { <Plug>VSurround}]=]
      vim.cmd [=[xmap < <Plug>VSurround>]=]
    end
  } -- }}}

  -- use 'tpope/vim-endwise'
  -- use 'Townk/vim-autoclose'

  use { "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use 'RRethy/nvim-treesitter-endwise'

  use { 'andymass/vim-matchup', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'szw/vim-maximizer'
  use 'simeji/winresizer'

  -- language-specific {{{
  -- use {'rgrinberg/vim-ocaml', ft = 'ocaml'}
  use 'LnL7/vim-nix'

  use { 'lervag/vimtex', -- {{{
    config = function()
    end
  }                                -- }}}

  use { 'lewis6991/gitsigns.nvim', --- {{{
    config = function()
      require('gitsigns').setup({
        current_line_blame_opts = {
          virt_text_pos = 'right_align',
          delay = 300,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local set_keymap = function(mode, l, r, opts)
            opts = opts or {}
            opts.noremap = true
            opts.silent = true
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          local pfx = function(k)
            return '<leader>g' .. k
          end

          set_keymap('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          set_keymap('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          set_keymap({ 'n', 'v' }, pfx 's', ':Gitsigns stage_hunk<CR>')
          set_keymap({ 'n', 'v' }, pfx 'r', ':Gitsigns reset_hunk<CR>')
          set_keymap('n', pfx 'b', function() gs.blame_line { full = true } end)
          set_keymap('n', pfx 'tb', gs.toggle_current_line_blame)
          set_keymap('n', pfx 'd', gs.diffthis)
          set_keymap('n', pfx 'dW', ':Gitsigns diffthis ')
          set_keymap('n', pfx 'dD', function() gs.diffthis('~') end)
          set_keymap('n', pfx 'td', gs.toggle_deleted)
        end
      })
    end
  } -- }}}

  use { 'kevinhwang91/nvim-bqf' }
  -- }}}

  if packer_bootstrap then
    require('packer').sync()
  end
end)
