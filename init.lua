local keymap = vim.api.nvim_set_keymap
local fn = vim.fn
local opt = vim.opt

vim.g.mapleader = ' '

opt.undofile = true
opt.autochdir = true

----------------
-- Appearance --
----------------
opt.list = true
opt.listchars = { tab = '>-', trail = '▫' }

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showcmd = true
opt.wildmenu = true

opt.fileencoding = "utf-8"

---------------------------
-- Indenting and Tabbing --
---------------------------
opt.expandtab = true -- '\t' will be inserted as ' '
opt.tabstop = 4 -- one '\t' will be displayed as four ' '
opt.shiftwidth = 4 -- One '\t' is equal to four ' '

opt.autoindent = true
opt.smartindent = true
opt.cindent = true

opt.autoread = true -- Read file when changed outside of Vim

-- Searching --
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
keymap('', '-', 'Nzz', {noremap = true})
keymap('', '=', 'nzz', {noremap = true})
keymap('', '<ESC>', ':nohlsearch<CR>', {noremap = true})

-- require 'azurice.key-mappings'

-------------------------
-- Bootstraping lazy.nvim --
-------------------------
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
opt.runtimepath : prepend(lazypath)

require('lazy').setup('plugins', {
    defaults = {
        version = "*", -- use the latest git commit, default: nil
    },
    checker = {
        enable = true, -- check updates for plugins automatically, default: false
    }
})
