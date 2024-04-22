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

  use { 'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = ':call fzf#install()' }
  }

  use { 'uga-rosa/utf8.nvim',
    config = function()
      _G.utf8 = require('utf8')
    end
  }

  use { 'folke/tokyonight.nvim', --- {{{
    config = function()
      require('tokyonight').setup({
        transparent = true,
        style = 'storm',
        terminal_colors = true,
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
        callback = function()
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
        callback = function()
          vim.api.nvim_set_hl(0, 'StatusLine', { link = 'MiniStatuslineModeNormal' })
        end
      })

      vim.cmd [[:color tokyonight]]
    end
  }                                 -- }}}

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
  use { 'williamboman/mason-lspconfig.nvim' }

  use { 'tamago324/nlsp-settings.nvim',
    config = function()
      require("nlspsettings").setup({
        config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers_fallback = { '.git' },
        append_default_schemas = true,
        loader = 'json'
      })
    end
  }

  use 'lukas-reineke/lsp-format.nvim'

  -- notification
  use { 'j-hui/fidget.nvim',
    config = function()
      require "fidget".setup {}
    end
  }
  -- }}}

  -- AI {{{
  use { "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = { ["*"] = true }
      })
    end,
  }

  use { 'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("CopilotChat").setup({
        show_help = false,
        context = 'buffers',
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>?', '', {
        desc = 'Open Copilot Chat',
        noremap = true,
        callback = function()
          require("CopilotChat").open({
            window = {
              layout = 'float'
            }
          })
        end
      })
    end
  }
  -- }}}

  -- completions {{{
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use { 'petertriho/cmp-git',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('cmp_git').setup()
    end
  }
  use 'ray-x/cmp-treesitter'
  use { 'onsails/lspkind.nvim',
    config = function()
      require('lspkind').init({
        symbol_map = {
          Copilot = '"'
        }
      })
    end
  }

  use { 'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua', 'nvim-cmp' },
    config = function()
      require('copilot_cmp').setup()
    end
  }
  -- }}}

  use 'RRethy/vim-illuminate'
  use 'L3MON4D3/LuaSnip'

  use { 'tpope/vim-surround',
    config = function()
      vim.cmd [=[xmap " <Plug>VSurround"]=]
      vim.cmd [=[xmap ' <Plug>VSurround']=]
      vim.cmd [=[xmap ( <Plug>VSurround)]=]
      vim.cmd [=[xmap [ <Plug>VSurround]]=]
      vim.cmd [=[xmap { <Plug>VSurround}]=]
      vim.cmd [=[xmap < <Plug>VSurround>]=]
    end
  }

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

  use { 'lervag/vimtex',
    config = function()
    end
  }
  -- }}}

  -- git {{{
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      local gs = require('gitsigns')

      gs.setup({
        current_line_blame_opts = {
          virt_text_pos = 'right_align',
          delay = 300,
        }
      })

      local set_keymap = function(mode, l, r, opts)
        opts = opts or {}
        opts.noremap = true
        opts.silent = true
        vim.keymap.set(mode, l, r, opts)
      end

      local pfx = function(k)
        return '<leader>g' .. k
      end

      set_keymap('n', ']c', "", {
        callback = function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Next hunk',
      })

      set_keymap('n', '[c', "", {
        callback = function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Previous hunk',
      })

      set_keymap({ 'n', 'v' }, pfx 's', ':Gitsigns stage_hunk<CR>')
      set_keymap({ 'n', 'v' }, pfx 'r', ':Gitsigns reset_hunk<CR>')
      set_keymap('n', pfx 'b', function() gs.blame_line { full = true } end)
      set_keymap('n', pfx 'tb', gs.toggle_current_line_blame)
      set_keymap('n', pfx 'd', gs.diffthis)
      set_keymap('n', pfx 'dW', ':Gitsigns diffthis ')
      set_keymap('n', pfx 'dD', function() gs.diffthis('~') end)
      set_keymap('n', pfx 'td', gs.toggle_deleted)
    end
  }

  use { "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup({
        enable = true,
        virtual_style = 'right_align',
      })

      vim.keymap.set('n', '<leader>gbv', '', {
        callback = function()
          require("blame").toggle({ args = 'virtual' })
        end,
        desc = 'Toggle blame virtual',
      })

      vim.keymap.set('n', '<leader>gbw', '', {
        callback = function()
          require("blame").toggle({ args = 'window' })
        end,
        desc = 'Toggle blame window',
      })
    end
  }
  --- }}}

  use { 'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<C-t>]],
        hide_numbers = true,
        direction = 'float',
        float_ops = { border = 'single' },
      })
    end
  }

  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
