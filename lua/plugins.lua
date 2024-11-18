local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { "ibhagwan/fzf-lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
      { 'junegunn/fzf', run = ':call fzf#install()' }
    },
  }

  use { 'uga-rosa/utf8.nvim',
    config = function()
      _G.utf8 = require('utf8')
    end
  }

  use { 'folke/tokyonight.nvim' }

  use { 'f-person/auto-dark-mode.nvim',
    config = function()
      require('auto-dark-mode').setup({
        set_dark_mode = function()
          vim.o.background = 'dark'
        end,
        set_light_mode = function()
          vim.o.background = 'light'
        end,
      })
    end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      ---@diagnostic disable-next-line: missing-fields
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "bash", "lua", "vim", "markdown", "markdown_inline" },
        auto_install = true,
        indent = { enable = true, },
        endwise = { enable = true }, -- for treesitter-endwise
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }

  use 'chentoast/marks.nvim'

  -- nvim-lsp {{{
  use 'folke/neoconf.nvim'

  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        PATH = 'append'
      })
    end
  }

  use { 'williamboman/mason-lspconfig.nvim',
    requires = { 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { "lua_ls" },
      }
    end
  }

  use { 'nvimdev/lspsaga.nvim',
    requires = { 'lewis6991/gitsigns.nvim', 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('lspsaga').setup({
        rename = {
          keys = {
            quit = '<ESC>',
          }
        },
        hover = {
          open_cmd = '!firefox',
        },
        lightbulb = {
          enable = false
        },
        code_action = {
          extend_gitsigns = true,
        },
        outline = {
          win_position = 'left',
        },
        symbol_in_winbar = {
          enable = false,
          color_mode = false,
          hide_keyword = true,
          folder_level = 0,
          separator = '.'
        }
      })

      vim.keymap.set('n', '<C-t>', '<cmd>Lspsaga term_toggle<CR>')
    end,
  }

  use { 'scalameta/nvim-metals',
    requires = 'nvim-lua/plenary.nvim',
    ft = "scala",
  }

  use { 'folke/lazydev.nvim', ft = 'lua',
    requires = { 'neovim/nvim-lspconfig' },
    config = function()
      require('lazydev').setup({
        debug = false,
        integrations = {
          lspconfig = true,
          cmp = true
        }
      })
    end,
  }
  --
  -- -- notification
  use { 'j-hui/fidget.nvim',
    config = function()
      require "fidget".setup {}
    end
  }
  -- -- }}}

  -- AI {{{
  use { "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true, hide_during_completion = true, },
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
  use 'hrsh7th/cmp-nvim-lsp-signature-help'

  use { 'zbirenbaum/copilot-cmp',
    requires = { 'zbirenbaum/copilot.lua', 'hrsh7th/nvim-cmp' },
    config = function()
      require('copilot_cmp').setup()
    end
  }
  -- }}}

  use 'RRethy/vim-illuminate'
  use 'L3MON4D3/LuaSnip'

  -- pair constructs {{{
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
  use { 'andymass/vim-matchup', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'RRethy/nvim-treesitter-endwise'
  -- }}}

  use 'szw/vim-maximizer'
  -- auto resizing windows
  use { 'nvim-focus/focus.nvim',
    config = function()
      require('focus').setup({
        ui = {
          colorcolumn = {
            enable = true,
            list = '+1,+2'
          }
        }
      })

      vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
        callback = vim.schedule_wrap(function()
          if vim.bo.buftype ~= '' then
            vim.b.focus_disable = true
          end
        end)
      })
    end
  }

  use { 'nvimdev/indentmini.nvim',
    config = function()
      require("indentmini").setup()
    end
  }

  -- language-specific {{{
  use { 'rgrinberg/vim-ocaml', ft = 'ocaml' }

  use { 'lervag/vimtex', ft = "tex" }
  -- }}}

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
          vim.schedule(function() gs.nav_hunk('next') end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Next hunk',
      })

      set_keymap('n', '[c', "", {
        callback = function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.nav_hunk('prev') end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Previous hunk',
      })

      set_keymap({ 'n', 'v' }, pfx 's', ':Gitsigns stage_hunk<CR>')
      set_keymap({ 'n', 'v' }, pfx 'r', ':Gitsigns reset_hunk<CR>')
      set_keymap('n', pfx 'b', function() gs.blame_line { full = true } end)
      set_keymap('n', pfx 'B', function() gs.blame() end)
      set_keymap('n', pfx 'tb', gs.toggle_current_line_blame)
      set_keymap('n', pfx 'd', gs.diffthis)
      set_keymap('n', pfx 'dW', ':Gitsigns diffthis ')
      set_keymap('n', pfx 'dD', function() gs.diffthis('~') end)
      set_keymap('n', pfx 'td', gs.toggle_deleted)
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
