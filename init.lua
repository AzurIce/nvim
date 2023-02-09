for k, _ in pairs(package.loaded) do
    if string.match(k, "^azurice") then
        package.loaded[k] = nil
    end
end

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


---------------
-- Keymaping --
---------------
keymap('c', 'w!!', ':SudaWrite', {})
keymap('', 's', '<nop>', {})
keymap('', 'S', ':w<CR>', {})
keymap('', 'Q', ':q<CR>', {})
keymap('', 'R', ':source $MYVIMRC<CR>', {})
-- keymap('', 'R', ':luafile init.lua<CR>', {})

keymap('', 'J', '7j', {noremap = true})
keymap('', 'K', '7k', {noremap = true})
keymap('', 'H', '<nop>', {})
keymap('', 'H', '0', {noremap = true})
keymap('', 'L', '<nop>', {})
keymap('', 'L', '$', {noremap = true})

-- keymap('v', '<Tab>', '>gv', {noremap = true})
-- keymap('v', '<S-Tab>', '<gv', {noremap = true})

keymap('n', '<C-a>', 'gg<S-v>G', {noremap = true})
keymap('v', '<C-c>', '"+y', {noremap = true})

-- Windowing
keymap('n', '<C-s>h', ':vsplit<CR>', {})         -- Ctrl + Shift + h: split left
keymap('n', '<C-s>j', ':split<CR><C-j>', {})     -- Ctrl + Shift + j: split down
keymap('n', '<C-s>k', ':split<CR>', {})          -- Ctrl + shift + k: split up
keymap('n', '<C-s>l', ':vsplit<CR><C-l>', {})    -- Ctrl + shift + k: split right
keymap('n', '<C-h>', '<C-w>h', {noremap = true})
keymap('n', '<C-j>', '<C-w>j', {noremap = true})
keymap('n', '<C-k>', '<C-w>k', {noremap = true})
keymap('n', '<C-l>', '<C-w>l', {noremap = true})

-- keymap('i', '<C-j>', 'v:lua.require\'cmp\'.scroll_docs(-4)', {noremap = true})
-- keymap('i', '<C-k>', 'v:lua.require\'cmp\'.scroll_docs(4)', {noremap = true})

keymap('n', '<C-A-j>', ':resize -2<CR>', {noremap = true})
keymap('n', '<C-A-k>', ':resize +2<CR>', {noremap = true})
keymap('n', '<C-A-h>', ':vertical resize -2<CR>', {noremap = true})
keymap('n', '<C-A-l>', ':vertical resize +2<CR>', {noremap = true})
-- Tabpaging
keymap('n', '<C-Tab>', '<nop>', {})
keymap('n', '<C-Tab>', 'v:count!=0? ":<C-u>" . v:count . "tabn<CR>" : ":tabn<CR>"', {noremap = true, expr = true})
keymap('n', '<C-S-Tab>', '<nop>', {})
keymap('n', '<C-S-Tab>', ':-tabn<CR>', {noremap = true})
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
    vim.cmd[[
        exec 'w'
        if &filetype == 'c'
            if has('win32')
                exec '!clang -target x86_64-pc-windows-gnu "%" -o "%<"'
            else
                exec '!gcc "%" -o "%<"'
            endif
        elseif &filetype == 'cpp'
            if has('win32')
                exec '!clang++ -target x86_64-pc-windows-gnu "%" -o "%<"'
            else
                exec '!g++ "%" -o "%<"'
            endif
        elseif &filetype == 'markdown'
            exec 'MarkdownPreview'
        endif
    ]]
end

if fn.has('win32') then
    opt.runtimepath : prepend(fn.stdpath('data') .. 'site/pack/packer/start/packer.vim')
end

-------------------------
-- Install packer.nvim --
-------------------------
local ensure_packer = function()
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    -- print(install_path)
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

------------------------
-- Manage the plugins --
------------------------
-- local use = require('packer').use
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    -- use 'mhartington/oceanic-next'
    -- use 'drewtempelmeyer/palenight.vim'
    -- use 'sainnhe/edge'
    use 'marko-cerovac/material.nvim'

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    use 'lambdalisue/suda.vim'

    -- 自动补全
    use 'hrsh7th/nvim-cmp'

    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- Snippet
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    use 'windwp/nvim-autopairs'

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    if not fn.has('win32') then
        use 'dundalek/lazy-lsp.nvim'
    else
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
    end

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons'
        }
    }

    use 'norcalli/nvim-colorizer.lua'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

vim.api.nvim_command 'PackerInstall'

-- Plugins

-- Colorscheme --
opt.termguicolors = true

-- Use light theme during 7 ~ 17
local current_hour = tonumber(os.date("%H"))
if current_hour >= 7 and current_hour <= 17 then
    vim.g.material_style = 'lighter'
    -- opt.background = 'light'
else
    vim.g.material_style = 'palenight'
    -- opt.background = 'dark'
end

-- edge colorscheme
-- vim.g.edge_style = 'neon'
-- vim.g.edge_better_performance = 1
-- -- vim.g.edge_transparent_background = 1
-- vim.g.edge_dim_inactive_windows = 1
-- vim.g.edge_diagnostic_text_highlight = 1
-- vim.g.edge_diagnostic_line_highlight = 1
-- vim.g.edge_diagnostic_virtual_text = 'colored'
-- vim.api.nvim_command 'colorscheme edge'


require('material').setup({
    contrast = {
        terminal = false, -- Enable contrast for the built-in terminal
        sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false, -- Enable contrast for floating windows
        cursor_line = false, -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
        filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { italic = true },
        strings = { --[[ bold = true ]] },
        keywords = { --[[ underline = true ]] },
        functions = { --[[ bold = true, undercurl = true ]] },
        variables = {},
        operators = {},
        types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        "gitsigns",
        -- "hop",
        -- "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        "nvim-cmp",
        -- "nvim-navic",
        "nvim-tree",
        "nvim-web-devicons",
        -- "sneak",
        -- "telescope",
        -- "trouble",
        -- "which-key",
    },

    disable = {
        colored_cursor = true, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false -- Enable higher contrast text for darker style
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to everride the default colors, set this to a function

    custom_highlights = {}, -- Overwrite highlights with your own
})
vim.cmd 'colorscheme material'

vim.g.winblend=10
if not fn.has('win32') then
    vim.cmd('hi Normal guibg=None ctermbg=None')
    -- vim.cmd('hi StatusLine guibg=None ctermbg=None')
    vim.cmd('hi CursorLine guibg=None ctermbg=None')
end

require'gitsigns'.setup()
require'colorizer'.setup()

require 'azurice.plugin-nvim-tree'
keymap('n', '<LEADER>e', ':NvimTreeToggle<CR>', {noremap = true})

require 'azurice.plugin-cmp'
require 'azurice.plugin-autopairs'
require 'azurice.plugin-lsp'
require 'azurice.plugin-nvim-treesitter'
