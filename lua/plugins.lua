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
  use { 'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup {}
    end
  }

  use { 'folke/tokyonight.nvim', -- {{{
    config = function()
      local normal = vim.api.nvim_command_output([[hi Normal]]):gsub('Normal%s*xxx%s', '')

      local bg
      do
        local guibg = normal:match('guibg=(#?%S+)')
        local ctermbg = normal:match('ctermbg=(#?%S+)')
        bg = guibg or ctermbg
      end

      vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
        callback = function()
          vim.cmd [[:color tokyonight]]
          vim.cmd(([[:hi LineNr guifg=%s]]):format(bg))
          -- clear background color for inactive window
          vim.cmd [[:hi Normal ctermbg=NONE guibg=NONE]]
          vim.cmd [[:hi NormalNC ctermbg=NONE guibg=NONE]]

          -- statusline
          vim.cmd [[:au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta]]
          vim.cmd [[:au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan]]
          vim.cmd [[:hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan]]
          vim.cmd [[:hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad]]
          vim.cmd [[:hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad]]
          vim.cmd [[:hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030]]
          vim.cmd [[:hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e]]
        end
      })
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
        endwise = { enable = true }, -- for treesitter-endwise
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
      }
    end
  } -- }}}

  -- nvim-lsp {{{
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use { 'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        automatic_install = true
      })
    end
  }

  use { 'jay-babu/mason-null-ls.nvim',
    config = function()
      require('mason-null-ls').setup {}
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
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = true
        },
        panel = { enabled = false },
        filetypes = { ["*"] = true }
      })
    end,
  }
  use {
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua', 'nvim-cmp' },
    config = function()
      require('copilot_cmp').setup()
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

  use {
    'Shougo/echodoc.vim',
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

  use {
    "windwp/nvim-autopairs",
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
