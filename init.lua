local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showcmd = true
opt.wildmenu = true

opt.encoding = "utf-8"

---------------------------
-- Indenting and Tabbing --
---------------------------
opt.expandtab = true -- '\t' will be inserted as ' '
opt.tabstop = 4 -- one '\t' will be displayed as four ' '
opt.shiftwidth = 4 -- One '\t' is equal to four ' '

opt.autoindent = true
opt.smartindent = true


opt.autoread = true -- Read file when changed outside of Vim


-------------------------
-- Install packer.nvim --
-------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

------------------------
-- Manage the plugins --
------------------------
local use = require('packer').use
require('packer').startup(function()
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'drewtempelmeyer/palenight.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- LSPs
require'lspconfig'.pyright.setup{}

-- Searching --
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
vim.api.nvim_set_keymap('', '-', 'Nzz', {noremap = true})
vim.api.nvim_set_keymap('', '=', 'nzz', {noremap = true})
vim.api.nvim_set_keymap('', '<ESC>', ':nohlsearch<CR>', {noremap = true})

-- Colorscheme --
opt.termguicolors = true
vim.api.nvim_command 'colorscheme palenight'

---------------
-- Keymaping --
---------------
vim.api.nvim_set_keymap('', 'H', '<nop>', {})
vim.api.nvim_set_keymap('', 'L', '<nop>', {})
vim.api.nvim_set_keymap('', 's', '<nop>', {})
vim.api.nvim_set_keymap('', 'S', ':w<CR>', {})
vim.api.nvim_set_keymap('', 'Q', ':q<CR>', {})
vim.api.nvim_set_keymap('', 'R', ':source $MYVIMRC<CR>', {})

vim.api.nvim_set_keymap('', 'J', '7j', {noremap = true})
vim.api.nvim_set_keymap('', 'K', '7k', {noremap = true})
vim.api.nvim_set_keymap('', 'H', '0', {noremap = true})
vim.api.nvim_set_keymap('', 'L', '$', {noremap = true})

-- Useful little things
vim.api.nvim_set_keymap('', '<C-J>', 'ddp', {noremap = true})
vim.api.nvim_set_keymap('', '<C-K>', 'ddkkp', {noremap = true})

