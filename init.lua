local keymap = vim.api.nvim_set_keymap
local fn = vim.fn
local opt = vim.opt

vim.g.mapleader = ' '

opt.list = true
opt.listchars = { tab = '>-', trail = '▫' }

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

if fn.has('win32') then
    opt.runtimepath : prepend(fn.stdpath('data') .. 'site/pack/packer/start/packer.vim')
end

-------------------------
-- Install packer.nvim --
-------------------------
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

------------------------
-- Manage the plugins --
------------------------
local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- 自动补全
    use 'hrsh7th/nvim-cmp'

    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- Snippet Engine
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'

    use 'drewtempelmeyer/palenight.vim'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        }
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

vim.api.nvim_command 'PackerInstall'

-- Plugins
require 'plugin-nvim-tree'
keymap('n', '<LEADER>e', ':NvimTreeToggle<CR>', {noremap = true})

require'plugin-cmp'
require'plugin-lsp.init'

-- Searching --
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
keymap('', '-', 'Nzz', {noremap = true})
keymap('', '=', 'nzz', {noremap = true})
keymap('', '<ESC>', ':nohlsearch<CR>', {noremap = true})

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
keymap('', 's', '<nop>', {})
keymap('', 'S', ':w<CR>', {})
keymap('', 'Q', ':q<CR>', {})
keymap('', 'R', ':source $MYVIMRC<CR>', {})

keymap('', 'J', '7j', {noremap = true})
keymap('', 'K', '7k', {noremap = true})
keymap('', 'H', '<nop>', {})
keymap('', 'H', '0', {noremap = true})
keymap('', 'L', '<nop>', {})
keymap('', 'L', '$', {noremap = true})

keymap('v', '<Tab>', '>gv', {noremap = true})
keymap('v', '<S-Tab>', '<gv', {noremap = true})

keymap('n', '<C-a>', 'gg<S-v>G', {noremap = true})
keymap('n', '<C-c>', '"+y', {noremap = true})

-- Windowing
keymap('n', '<C-s>h', ':vsplit<CR>', {})
keymap('n', '<C-s>j', ':split<CR><C-j>', {})
keymap('n', '<C-s>k', ':split<CR>', {})
keymap('n', '<C-s>l', ':vsplit<CR><C-l>', {})
keymap('n', '<C-h>', '<C-w>h', {noremap = true})
keymap('n', '<C-j>', 'v:lua.require\'cmp\'.visible() ? v:lua.require\'cmp\'.scroll_docs(4)  : "<C-w>j"', {noremap = true, expr = true})
keymap('n', '<C-k>', 'v:lua.require\'cmp\'.visible() ? v:lua.require\'cmp\'.scroll_docs(-4) : "<C-w>k"', {noremap = true, expr = true})
keymap('n', '<C-l>', '<C-w>l', {noremap = true})

keymap('n', '<C-A-j>', ':resize -2<CR>', {noremap = true})
keymap('n', '<C-A-k>', ':resize +2<CR>', {noremap = true})
keymap('n', '<C-A-h>', ':vertical resize -2<CR>', {noremap = true})
keymap('n', '<C-A-l>', ':vertical resize +2<CR>', {noremap = true})
-- Tabpaging
keymap('n', '<Tab>', 'v:count!=0? ":<C-u>" . v:count . "tabn<CR>" : ":tabn<CR>"', {noremap = true, expr = true})
keymap('n', '<S-Tab>', ':-tabn<CR>', {noremap = true})
keymap('n', '<C-n>', ':tabe<CR>', {noremap = true})

-- Jumping
-- keymap('n', '<C-]>', 'gf', {noremap = true})
-- keymap('n', '<C-[>', ':e#<CR>', {noremap = true})

-- Useful little things
-- keymap('', '<C-S-J>', 'ddp', {noremap = true})
-- keymap('', '<C-S-K>', 'ddkkp', {noremap = true})

-------------
-- Compile --
-------------
keymap('n', '<LEADER>c', ':call v:lua.Compile()<CR>', {noremap = true})
function Compile()
    if fn.has('win32') then
        vim.cmd[[
            exec 'w'
            if &filetype == 'c'
                exec '!gcc "%" -o "%<"'
            elseif &filetype == 'cpp'
                exec '!g++ "%" -o "%<"'
            elseif &filetype == 'markdown'
                exec 'MarkdownPreview'
            endif
        ]]
    else
        vim.cmd[[
            exec 'w'
            if &filetype == 'c'
                exec '!gcc "%" -o "%<"'
            elseif &filetype == 'cpp'
                exec '!g++ "%" -o "%<"'
            elseif &filetype == 'markdown'
                exec 'MarkdownPreview'
            endif
        ]]
    end
end
