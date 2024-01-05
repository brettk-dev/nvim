-- Automatically load lazy nvim plugin manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- The plugins list
local plugins = {
  -- Colors
  "altercation/vim-colors-solarized",
  -- Utility
  "nvim-lua/plenary.nvim",
  -- LSP/Autocomplete
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "nvimtools/none-ls.nvim",
  -- Fuzzy file finder
  "junegunn/fzf",
  "junegunn/fzf.vim",
  -- Syntax
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- Editing
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  "ggandor/leap.nvim",
}

-- Load the plugins
require("lazy").setup(plugins)
