local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Packer removal
  -- "wbthomason/packer.nvim", -- No longer needed

  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('fzf-lua').setup({ 'skim' })

      local pfx = '<leader>f'

      vim.keymap.set('n', pfx, ':FzfLua ')
      vim.keymap.set('n', pfx .. 'b', '<cmd>FzfLua buffers<CR>')
      vim.keymap.set('n', pfx .. 't', '<cmd>FzfLua tabs<CR>')
      vim.keymap.set('n', pfx .. 'T', '<cmd>FzfLua tabs<CR>')
    end,
  },

  { 'folke/tokyonight.nvim' },

  {
    'f-person/auto-dark-mode.nvim',
    config = function()
      require('auto-dark-mode').setup({
        set_dark_mode = function()
          vim.o.background = 'dark'
        end,
        set_light_mode = function()
          vim.o.background = 'light'
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      local ts = require('nvim-treesitter')
      local ensure_installed = { 'zsh', 'bash', 'lua', 'vim', 'markdown', 'markdown_inline' }
      local installed = ts.get_installed()

      for _, parser in ipairs(ensure_installed) do
        if not vim.tbl_contains(installed, parser) then
          vim.schedule(function()
            pcall(ts.install, parser)
          end)
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      require('nvim-treesitter').setup({
        ensure_installed = { 'bash', 'lua', 'vim', 'markdown', 'markdown_inline' },
        auto_install = true,
        indent = { enable = true },
        endwise = { enable = true }, -- for treesitter-endwise
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  { 'chentoast/marks.nvim' },

  -- nvim-lsp {{{
  -- 'nymphium/neoconf.nvim'
  -- {
  --   'mrjones2014/codesettings.nvim',
  --   config = function()
  --     require('codesettings').setup({
  --       config_file_paths = { '.vscode/settings.json', '.codesettings.json', ',codesettings.json' },
  --       live_reload = true,
  --     })
  --   end,
  -- },

  { 'neovim/nvim-lspconfig' },

  { 'mason-org/mason.nvim' },
  { 'mason-org/mason-lspconfig.nvim', dependencies = { 'neovim/nvim-lspconfig' } },

  { 'nvimdev/lspsaga.nvim',           dependencies = { 'lewis6991/gitsigns.nvim', 'nvim-treesitter/nvim-treesitter' } },

  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end,
      })

      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true,
      })
      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Re-enable autoformat-on-save',
      })
    end,
  },

  {
    'SmiteshP/nvim-navbuddy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('nvim-navbuddy').setup()
    end,
  },

  -- Lua
  {
    'folke/lazydev.nvim',
    ft = { 'lua' },
    config = function()
      require('lazydev').setup({})
    end,
  },

  -- notification
  {
    'rcarriga/nvim-notify',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('notify').setup({
        timeout = 2500,
        level = 1,
        render = 'compact',
        fps = 60,
      })
    end,
  },
  -- }}}

  {
    'folke/noice.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = function()
      require('noice').setup({
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        presets = {
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
        },
      })
    end,
  },

  -- AI {{{
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = true, hide_during_completion = true },
        panel = { enabled = false },
        filetypes = { ['*'] = true },
      })
    end,
  },

  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.diff',
      'j-hui/fidget.nvim',
      'ravitemer/mcphub.nvim'
    },
    config = function()
      local pfx = '<leader>a'

      -- require('codecompanion_spinner'):init()
      require('codecompanion').setup({
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
        },
        display = {
          chat = {
            show_header_separator = true,
          },
        },
      })

      vim.keymap.set({ 'n', 'v' }, pfx .. 'e', '<cmd>CodeCompanion<CR>', { silent = true, desc = 'CodeCompanion' })
      vim.keymap.set(
        { 'n', 'v' },
        pfx .. 't',
        '<cmd>CodeCompanionChat<CR>',
        { silent = true, desc = 'CodeCompanion Chat' }
      )
      vim.keymap.set(
        { 'n', 'v' },
        pfx .. 'a',
        '<cmd>CodeCompanionAction<CR>',
        { silent = true, desc = 'CodeCompanion Action' }
      )
    end,
  },

  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup({
        auto_approve = true,
        mcp_request_timeout = 120000,
        extensions = {
          codecompanion = { make_slash_commands = true },
        },
      })
    end,
  },
  -- }}}

  -- completions {{{
  {
    'saghen/blink.cmp',
    dependencies = { 'giuxtaposition/blink-cmp-copilot', 'Kaiser-Yang/blink-cmp-avante' },
    version = '*',
    config = function()
      require('blink.cmp').setup({
        completion = {
          documentation = { auto_show = true },
          trigger = { show_on_keyword = true, show_on_insert_on_trigger_character = true },
          list = { selection = { auto_insert = true, preselect = true } },
          menu = {
            draw = { columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } } },
          },
        },
        cmdline = { completion = { ghost_text = { enabled = true } } },
        sources = {
          default = {
            'lsp',
            'path',
            'buffer',
            'copilot',
          },
          per_filetype = {
            codecompanion = { 'codecompanion' },
          },
          providers = {
            copilot = {
              name = 'copilot',
              module = 'blink-cmp-copilot',
              score_offset = 100,
              async = true,
            },
            codecompanion = {
              name = 'CodeCompanion',
              module = 'codecompanion.providers.completion.blink',
              score_offset = 100,
              enabled = true,
            },
          },
        },
        fuzzy = {
          implementation = 'prefer_rust',
          prebuilt_binaries = {
            download = true,
            force_version = 'main',
          },
        },

        keymap = {
          ['<Tab>'] = { 'select_next', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
          ['<C-e>'] = { 'cancel' },
          ['<C-x>'] = { 'show_and_insert' },
          ['<CR>'] = {
            'accept',
            'fallback_to_mappings',
          },
        },
      })
    end,
  },

  {
    'giuxtaposition/blink-cmp-copilot',
    dependencies = { 'zbirenbaum/copilot.lua' }, -- Added dependency for safety
  },

  {
    'onsails/lspkind.nvim',
    config = function()
      require('lspkind').init({
        symbol_map = {
          Copilot = '',
        },
      })
    end,
  },

  -- }}}

  { 'RRethy/vim-illuminate' },

  -- pair constructs {{{
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },
  { 'andymass/vim-matchup',          dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  { 'RRethy/nvim-treesitter-endwise' },
  -- }}}

  -- auto resizing windows
  {
    'nvim-focus/focus.nvim',
    config = function()
      local focus = require('focus')
      focus.setup({})

      local ignore_buftypes = { 'nofile', 'popup' }
      local ignore_filetypes = { 'codecompanion' }

      local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

      vim.keymap.set('n', '<F3>', function()
        focus.focus_maximise()
      end)

      vim.api.nvim_create_autocmd({ 'WinEnter', 'BufNew', 'BufEnter' }, {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
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
    end,
  },

  {
    'nvimdev/indentmini.nvim',
    config = function()
      require('indentmini').setup()
    end,
  },

  -- language-specific {{{
  { 'lervag/vimtex', ft = 'tex' },

  {
    'OXY2DEV/markview.nvim',
    ft = { 'markdown', 'markdown_inline', 'html' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('markview').setup({
        preview = {
          filetypes = { 'markdown', 'codecompanion' },
          ignore_buftypes = {},
        },
      })
    end,
  },
  -- }}}

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gs = require('gitsigns')

      gs.setup({
        current_line_blame_opts = {
          virt_text_pos = 'right_align',
          delay = 300,
        },
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
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.nav_hunk('next')
          end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Next hunk',
      })

      set_keymap('n', '[c', '', {
        callback = function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.nav_hunk('prev')
          end)
          return '<Ignore>'
        end,
        expr = true,
        desc = 'Previous hunk',
      })

      set_keymap({ 'n', 'v' }, pfx('s'), ':Gitsigns stage_hunk<CR>')
      set_keymap({ 'n', 'v' }, pfx('r'), ':Gitsigns reset_hunk<CR>')
      set_keymap('n', pfx('b'), function()
        gs.blame_line({ full = true })
      end)
      set_keymap('n', pfx('B'), function()
        gs.blame()
      end)
      set_keymap('n', pfx('tb'), gs.toggle_current_line_blame)
      set_keymap('n', pfx('d'), gs.diffthis)
      set_keymap('n', pfx('dW'), ':Gitsigns diffthis ')
      set_keymap('n', pfx('dD'), function()
        gs.diffthis('~')
      end)
      set_keymap('n', pfx('td'), gs.preview_hunk_inline)
    end,
  },

  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<C-t>]],
        direction = 'horizontal',
        autochdir = true,
        shading_terminals = false,
        shading_factor = 0,
        start_in_insert = true,
      })
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
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
      vim.keymap.set('n', '<leader>g?', '', {
        callback = function()
          lazygit:toggle()
        end,
      })
    end,
  },

  {
    'mikavilpas/yazi.nvim',
    dependencies = {
      'ibhagwan/fzf-lua',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('yazi').setup({
        open_for_directories = true,
      })
      vim.keymap.set('n', '<leader>t', '<cmd>Yazi<cr>', { noremap = true, silent = true, desc = 'Yazi Toggle' })
    end,
  },
})
