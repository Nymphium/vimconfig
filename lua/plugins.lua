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
    },
    config = function()
      require('fzf-lua').setup({ 'skim' })

      local pfx = '<leader>f'

      vim.keymap.set('n', pfx .. 'b', '<cmd>FzfLua buffers<CR>')
      vim.keymap.set('n', pfx .. 't', '<cmd>FzfLua tabs<CR>')
      vim.keymap.set('n', pfx .. 'T', '<cmd>FzfLua tabs<CR>')
    end
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
  }

  use { 'folke/lazydev.nvim' }

  use { "WieeRd/auto-lsp.nvim",
    requires = { "neovim/nvim-lspconfig" },
  }

  use { 'nvimdev/lspsaga.nvim',
    requires = { 'lewis6991/gitsigns.nvim', 'nvim-treesitter/nvim-treesitter' },
  }

  use { 'scalameta/nvim-metals',
    requires = 'nvim-lua/plenary.nvim',
    ft = "scala",
  }

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
        suggestion = { enabled = true, hide_during_completion = true, },
        panel = { enabled = false },
        filetypes = { ["*"] = true }
      })
    end,
  }

  -- use { 'CopilotC-Nvim/CopilotChat.nvim',
  --   requires = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     require("CopilotChat").setup({
  --       context = 'buffers',
  --     })
  --
  --     vim.keymap.set({ 'n', 'v' }, '<leader>?', '', {
  --       desc = 'Open Copilot Chat',
  --       noremap = true,
  --       callback = function()
  --         require("CopilotChat").open({
  --           window = {
  --             layout = 'float'
  --           }
  --         })
  --       end
  --     })
  --   end
  -- }

  use {
    'yetone/avante.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
      'MunifTanjim/nui.nvim',
      "ravitemer/mcphub.nvim",
    },
    branch = 'main',
    run = 'make',
    config = function()
      require('avante').setup({
        provider = 'copilot',
        behaviour = {
          enable_cursor_planning_mode = true,
        },
        windows = {
          file_selector = 'fzf',
          position = 'smart',
          ask = {
            floating = true,
            start_insert = false,
          },
          edit = {
            start_insert = true,
          },
        },

        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          if hub == nil then
            return nil
          end
          return hub:get_active_servers_prompt()
        end,
        -- custom_tools = function()
        --   return {
        --     require("mcphub.extensions.avante").mcp_tool(),
        --   }
        -- end,
      })


      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if vim.startswith(vim.bo.filetype, 'Avante') then
            vim.opt_local.foldmethod = 'manual'
            vim.opt_local.foldlevel = 0
            vim.opt_local.foldenable = true
          end
        end
      })
    end
  }

  use {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    run = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        auto_approve = true,
      })
    end,
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
  use { 'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {}

      -- vim.cmd [=[xmap " <Plug>(nvim-surround-visual)"]=]
      -- vim.cmd [=[xmap ' <Plug>(nvim-surround-visual)']=]
      -- vim.cmd [=[xmap ( <Plug>(nvim-surround-visual))]=]
      -- vim.cmd [=[xmap [ <Plug>(nvim-surround-visual)]]=]
      -- vim.cmd [=[xmap { <Plug>(nvim-surround-visual)}]=]
      -- vim.cmd [=[xmap < <Plug>(nvim-surround-visual)>]=]
    end
  }

  use { "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use { 'andymass/vim-matchup', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'RRethy/nvim-treesitter-endwise'
  -- }}}

  -- auto resizing windows
  use { 'nvim-focus/focus.nvim',
    config = function()
      require('focus').setup({
        autoresize = { enable = false },
        ui = {
          colorcolumn = {
            enable = true,
            list = '+1,+2'
          }
        }
      })

      vim.keymap.set('n', '<F3>', function()
        require('focus').focus_toggle_window()
      end)
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

  use { 'OXY2DEV/markview.nvim', ft = { 'markdown', 'markdown_inline', 'html' },
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    }
  }
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
      set_keymap('n', pfx 'td', gs.preview_hunk_inline)
    end
  }

  use { 'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<C-t>]],
        direction = 'float',
        autochdir = true,
        float_ops = { border = 'curved' },
        highlights = { winblend = 0 },
      })
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({
        cmd = "lazygit",
        count = 5,
        dir = "git_dir",
        float_opts = { border = 'single' },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(_)
          vim.cmd("startinsert!")
        end,
      })
      vim.keymap.set('n', '<leader>g?', '', { callback = function() lazygit:toggle() end })
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
