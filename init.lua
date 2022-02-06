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

local fn = vim.fn

if fn.has('win32') then
    opt.runtimepath : prepend(fn.stdpath('data') .. 'site/pack/packer/start/packer.vim')
end

-------------------------
-- Install packer.nvim --
-------------------------
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
  -- use 'neovim/nvim-lspconfig'
  use 'drewtempelmeyer/palenight.vim'
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use {'neoclide/coc.nvim', branch = 'release'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.api.nvim_command 'PackerInstall'

-- LSPs
-- require'lspconfig'.pyright.setup{}
-- require'lspconfig'.clangd.setup{}

-- Coc.nvim
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"',
    { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR>"',
    { noremap = true, expr = true, silent = true })

vim.g.coc_global_extensions = {
    'coc-clangd',
    'coc-cmake',
    'coc-css',
    'coc-cssmodules',
    'coc-eslint',
    'coc-git',
    'coc-glslx',
    'coc-go',
    'coc-golines',
    'coc-highlight',
    'coc-html',
    'coc-java',
    'coc-json',
    'coc-ltex',
    'coc-markdownlint',
    'coc-markdown-preview-enhanced',
    'coc-powershell',
    'coc-prettier',
    'coc-pydocstring',
    'coc-pyright',
    'coc-sh',
    'coc-stylelintplus',
    'coc-svg',
    'coc-tailwindcss',
    'coc-tsserver',
    'coc-vimlsp',
    'coc-xml',
    'coc-yaml'
}

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
vim.g.background=dark
vim.g.winblend=10
if not fn.has('win32') then
    vim.cmd('hi Normal guibg=None ctermbg=None')
    -- vim.cmd('hi StatusLine guibg=None ctermbg=None')
    vim.cmd('hi CursorLine guibg=None ctermbg=None')
end

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
-- vim.api.nvim_set_keymap('', '<C-S-J>', 'ddp', {noremap = true})
-- vim.api.nvim_set_keymap('', '<C-S-K>', 'ddkkp', {noremap = true})

vim.g.mapleader = ' '
vim.api.nvim_set_keymap('', '<LEADER>e', ':NERDTreeToggle<CR>', {noremap = true})
vim.g.NERDTreeMapChangeRoot = 'l'
vim.g.NERDTreeMapUpdir = 'h'
vim.g.NERDTreeMapUpdirKeepOpen = ''
-- Exit Vim if NERDTree is the only window remaining in the only tab.
vim.cmd([[
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])
-- Close the tab if NERDTree is the only window remaining in it.
vim.cmd([[
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])

