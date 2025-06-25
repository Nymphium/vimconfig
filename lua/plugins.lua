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

  use { 'ibhagwan/fzf-lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
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
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      ---@diagnostic disable-next-line: missing-fields
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { 'bash', 'lua', 'vim', 'markdown', 'markdown_inline' },
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

  use { 'mason-org/mason.nvim' }
  use { 'mason-org/mason-lspconfig.nvim',
    requires = { 'neovim/nvim-lspconfig' },
  }

  use { 'nvimdev/lspsaga.nvim',
    requires = { 'lewis6991/gitsigns.nvim', 'nvim-treesitter/nvim-treesitter' },
  }

  use { 'lukas-reineke/lsp-format.nvim' }

  use {
    'SmiteshP/nvim-navbuddy',
    requires = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('nvim-navbuddy').setup()
    end
  }

  -- Lua
  use { 'folke/lazydev.nvim',
    ft = { 'lua' },
    config = function()
      require('lazydev').setup({
        integrations = {
          cmp = false,
          coq = false,
        },
      })
    end
  }

  use { 'WieeRd/auto-lsp.nvim',
    requires = { 'neovim/nvim-lspconfig' },
  }

  -- notification
  use { 'j-hui/fidget.nvim',
    config = function()
      require 'fidget'.setup {}
    end
  }
  -- }}}

  -- AI {{{
  use { 'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = true, hide_during_completion = true, },
        panel = { enabled = false },
        filetypes = { ['*'] = true }
      })
    end,
  }

  use {
    "olimorris/codecompanion.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.diff",
      'j-hui/fidget.nvim'
    },
    config = function()
      local pfx = '<leader>a'

      require('codecompanion_spinner'):init()
      require("codecompanion").setup({
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true
            }
          }
        },
        display = {
          chat = {
            show_header_separator = true,
          }
        },
      })

      vim.keymap.set({ 'n', 'v' }, pfx .. 'e', '<cmd>CodeCompanion<CR>', { silent = true, desc = 'CodeCompanion' })
      vim.keymap.set({ 'n', 'v' }, pfx .. 't', '<cmd>CodeCompanionChat<CR>',
        { silent = true, desc = 'CodeCompanion Chat' })
      vim.keymap.set({ 'n', 'v' }, pfx .. 'a', '<cmd>CodeCompanionAction<CR>',
        { silent = true, desc = 'CodeCompanion Action' })
    end
  }

  use {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    run = 'npm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup({
        auto_approve = true,
        extensions = {
          avante = { make_slash_commands = true },
        }
      })
    end,
  }
  -- }}}

  -- completions {{{
  use { 'saghen/blink.cmp',
    requires = { 'giuxtaposition/blink-cmp-copilot',
      'Kaiser-Yang/blink-cmp-avante',
    },
    config = function()
      require('blink.cmp').setup {
        completion = {
          documentation = { auto_show = true },
          trigger = { show_on_keyword = true, show_on_insert_on_trigger_character = true },
          list = { selection = { preselect = true } },
          menu = { draw = { columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } }, } }
        },
        cmdline = { completion = { ghost_text = { enabled = true } } },
        sources = {
          default = {
            'lsp', 'path', 'buffer', 'copilot'
          },
          per_filetype = {
            codecompanion = { "codecompanion" },
          },
          providers = {
            copilot = {
              name = 'copilot',
              module = 'blink-cmp-copilot',
              score_offset = 100,
              async = true,
            },
            avante = {
              module = 'blink-cmp-avante',
              name = 'Avante',
            },
            codecompanion = {
              name = "CodeCompanion",
              module = "codecompanion.providers.completion.blink",
              score_offset = 100,
              enabled = true,
            },
            -- lazydev = {
            --   name = 'LazyDev',
            --   module = 'lazydev.integrations.blink',
            --   -- make lazydev completions top priority (see `:h blink.cmp`)
            --   score_offset = 100,
            -- },
          },
        },
        fuzzy = { implementation = 'lua' },

        keymap = {
          ['<Tab>'] = { 'select_next', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
          ['<C-e>'] = { 'cancel' },
          ['<C-x>'] = { 'show_and_insert' },
          ['<CR>'] = {
            'accept',
            'fallback_to_mappings'
          },
        },
      }
    end
  }

  use {
    'giuxtaposition/blink-cmp-copilot',
    after = { 'copilot.lua' },
  }

  -- use 'ray-x/cmp-treesitter'
  use { 'onsails/lspkind.nvim',
    config = function()
      require('lspkind').init({
        symbol_map = {
          Copilot = ''
        }
      })
    end
  }

  -- }}}

  use 'RRethy/vim-illuminate'

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

  use { 'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }
  use { 'andymass/vim-matchup', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'RRethy/nvim-treesitter-endwise'
  -- }}}

  -- auto resizing windows
  use { 'nvim-focus/focus.nvim',
    config = function()
      local focus = require('focus')
      focus.setup({})

      local ignore_buftypes = { 'nofile', 'prompt', 'popup' }
      local ignore_filetypes = { 'Avante', 'AvanteInput', 'AvanteSelectedFiles', 'AvanteTodos' }

      local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

      vim.keymap.set('n', '<F3>', function()
        focus.focus_maximise()
      end)

      vim.api.nvim_create_autocmd('WinEnter', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
          then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for BufType',
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
          else
            vim.b.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for FileType',
      })
    end
  }

  use { 'nvimdev/indentmini.nvim',
    config = function()
      require('indentmini').setup()
    end
  }

  -- language-specific {{{
  use { 'lervag/vimtex', ft = 'tex' }

  use { 'OXY2DEV/markview.nvim', ft = { 'markdown', 'markdown_inline', 'html' },
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('markview').setup({
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      })
    end
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

      set_keymap('n', ']c', '', {
        callback = function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.nav_hunk('next') end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Next hunk',
      })

      set_keymap('n', '[c', '', {
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
        cmd = 'lazygit',
        count = 5,
        dir = 'git_dir',
        float_opts = { border = 'single' },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd('startinsert!')
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        on_close = function(_)
          vim.cmd('startinsert!')
        end,
      })
      vim.keymap.set('n', '<leader>g?', '', { callback = function() lazygit:toggle() end })
    end
  }

  use { 'mikavilpas/yazi.nvim',
    config = function()
      require('yazi').setup({
        open_for_directories = true
      })
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
