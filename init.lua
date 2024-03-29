vim.g.mapleader = " "

require("my_lazy")

-- Plugin configurations
require("my_fzf")
require("my_lsp")
require("my_tabnine")
require("my_treesitter")

-- Simple plugin setups
require("autoclose").setup()
require("leap").create_default_mappings()
require("lualine").setup()
require("nvim-surround").setup()
require("nvim-ts-autotag").setup()
require("Comment").setup()

vim.opt.background = "dark"
vim.cmd("colorscheme gruvbox")

-- Set tab width to 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Show relative numbers and the current line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep a buffer of lines above and below the cursor
vim.opt.scrolloff = 7

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Add a vertical indicator at column 80
vim.opt.colorcolumn = "80"

-- Use the host clipboard
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
