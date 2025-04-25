-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
    vim.cmd('colorscheme rose-pine')
    end

  })

  -- Fast language syntax highlighting
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- Fast navigation of favorite files
  use('theprimeagen/harpoon')

  -- Undo
  use('mbbill/undotree')

  -- Git Plugins
  use('tpope/vim-fugitive')
  use('lewis6991/gitsigns.nvim')

  -- Comment out code
  use('numToStr/Comment.nvim')
end)
