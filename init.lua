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
opt.tabstop = 4      -- one '\t' will be displayed as four ' '
opt.shiftwidth = 4   -- One '\t' is equal to four ' '

opt.autoindent = true
opt.smartindent = true
opt.cindent = true

opt.autoread = true -- Read file when changed outside of Vim

-- Searching --
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
keymap('', '-', 'Nzz', { noremap = true })
keymap('', '=', 'nzz', { noremap = true })
keymap('', '<ESC>', ':nohlsearch<CR>', { noremap = true })

require 'azurice.key-mappings'

--- Notify command output.
---@param msg string
---@param sc vim.SystemCompleted
---@param level integer|nil

-- rocks.nvim bootstrap / Nix integration
--
-- Nix mode:    if ~/.local/share/nvim/nvim-nix/generated-by-nix.lua exists,
--              use Nix-provided luarocks wrapper (with rust-mlua backend).
-- Fallback:    otherwise use plain "luarocks" or git bootstrap.
--
do
    local install_location = vim.fs.joinpath(vim.fn.stdpath("data"), "rocks")

    local nix_data_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "nvim-nix")
    local nix_deps_path = vim.fs.joinpath(nix_data_dir, "generated-by-nix.lua")
    local luarocks_config_path = vim.fs.joinpath(nix_data_dir, "luarocks-config-generated.lua")

    local has_nix_deps = vim.fn.filereadable(nix_deps_path) == 1
    local has_luarocks_config = vim.fn.filereadable(luarocks_config_path) == 1

    local rocks_config

    if has_nix_deps and has_luarocks_config then
        -- Nix integration mode
        local nix_deps = dofile(nix_deps_path)
        local luarocks_config_fn = assert(loadfile(luarocks_config_path))

        rocks_config = {
            rocks_path = vim.fs.normalize(install_location),
            luarocks_binary = nix_deps.luarocks_executable,
            luarocks_config = luarocks_config_fn(),
        }
    else
        -- Fallback / Bootstrap mode (Linux or non-Nix setups)
        rocks_config = {
            rocks_path = vim.fs.normalize(install_location),
            luarocks_binary = "luarocks",
        }
    end

    vim.g.rocks_nvim = rocks_config

    -- Configure the package path (so that plugin code can be found)
    local luarocks_path = {
        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
    }
    package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

    -- Configure the C path (so that e.g. tree-sitter parsers can be found)
    local luarocks_cpath = {
        vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
    }
    package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

    -- Add rocks.nvim to the runtimepath
    vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
end

-- If rocks.nvim is not installed then install it!
if not pcall(require, "rocks") then
    local rocks_config = vim.g.rocks_nvim
    local has_luarocks = vim.fn.executable(rocks_config.luarocks_binary) == 1

    if has_luarocks then
        local env = vim.fn.environ()
        if env.HTTP_PROXY and not env.HTTPS_PROXY then
            env.HTTPS_PROXY = env.HTTP_PROXY
        end

        local sc = vim.system({
            rocks_config.luarocks_binary,
            "--lua-version=5.1",
            "--tree=" .. rocks_config.rocks_path,
            "install",
            "rocks.nvim",
        }, { env = env }):wait()

        if sc.code ~= 0 then
            vim.notify(
                "Installing rocks.nvim failed:\nstderr: " .. (sc.stderr or "") .. "\nstdout: " .. (sc.stdout or ""),
                vim.log.levels.ERROR
            )
            return
        end
    else
        -- Bootstrap for non-Nix systems without luarocks
        local rocks_location = vim.fs.joinpath(vim.fn.stdpath("cache"), "rocks.nvim")

        if not vim.uv.fs_stat(rocks_location) then
            local url = "https://github.com/lumen-oss/rocks.nvim"
            vim.fn.system({ "git", "clone", "--filter=blob:none", url, rocks_location })
            assert(vim.v.shell_error == 0, "rocks.nvim installation failed. Try exiting and re-entering Neovim!")
        end

        vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))
        vim.fn.delete(rocks_location, "rf")
    end
end
