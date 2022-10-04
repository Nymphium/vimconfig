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

local packer = require 'packer'
local use = packer.use

local use_lazy = function(pkg)
  use { pkg, opt = true }
end

packer.startup(function()
  use_lazy 'wbthomason/packer.nvim'

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
  } -- }}}

  use { 'scrooloose/nerdcommenter', -- {{{
    config = function()
      vim.cmd [[let NERDSpaceDelims = 1]]
      vim.api.nvim_set_keymap('n', '<M-C>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<M-C>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
    end
  } -- }}}

  use { 'nvim-treesitter/nvim-treesitter', -- {{{
    run = ':TSUpdate',
    config = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "typescript", "haskell", "ocaml", "bash", "lua", "vim" },
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
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'RRethy/vim-illuminate'
  use 'folke/lsp-colors.nvim'
  use 'L3MON4D3/LuaSnip'
  use { "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use 'lukas-reineke/lsp-format.nvim'
  use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- {{{
    config = function()
      require("lsp_lines").setup()

      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  } -- }}}
  -- }}}

  use 'Shougo/echodoc.vim'
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

  use 'tpope/vim-endwise'
  use 'Townk/vim-autoclose'

  use { 'andymass/vim-matchup', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'szw/vim-maximizer'
  use 'simeji/winresizer'

  -- language-specific {{{
  -- use {'rgrinberg/vim-ocaml', ft = 'ocaml'}
  use 'drmingdrmer/vim-indent-lua'
  use 'LnL7/vim-nix'

  use { 'lervag/vimtex', -- {{{
    config = function()
    end
  } -- }}}

  -- }}}

  if packer_bootstrap then
    packer.sync()
  end
end)
