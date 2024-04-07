local keymap = vim.api.nvim_set_keymap
local opt = vim.opt

vim.g.mapleader = ' '

opt.undofile = true
opt.autochdir = false

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

require 'azurice.key-mappings'

-------------------------
-- Bootstraping lazy.nvim --
-------------------------
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- opt.runtimepath : prepend(lazypath)
-- 
-- require('lazy').setup('plugins', {
--     defaults = {
--         version = "*", -- use the latest git commit, default: nil
--     },
--     checker = {
--         enable = true, -- check updates for plugins automatically, default: false
--     }
-- })

--- Notify command output.
---@param msg string
---@param sc vim.SystemCompleted
---@param level integer|nil
local function notify_output(msg, sc, level)
    local function remove_shell_color(s)
        return tostring(s):gsub("\x1B%[[0-9;]+m", "")
    end
    vim.notify(
        table.concat({
            msg,
            sc and "stderr: " .. remove_shell_color(sc.stderr),
            sc and "stdout: " .. remove_shell_color(sc.stdout),
        }, "\n"),
        level
    )
end

local rocks_config = {
    rocks_path = vim.fn.stdpath("data") .. "/rocks",
    luarocks_binary = "luarocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

if not vim.uv.fs_stat(rocks_config.rocks_path) then
  local sc = vim.system({
    rocks_config.luarocks_binary,
    "--lua-version=5.1",
    "--tree=" .. rocks_config.rocks_path,
    "--server='https://nvim-neorocks.github.io/rocks-binaries/'",
    "install",
    "rocks.nvim",
    }):wait()
  if sc.code ~= 0 then
      notify_output("Installing rocks.nvim failed:", sc, vim.log.levels.ERROR)
      return
  end
end

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
