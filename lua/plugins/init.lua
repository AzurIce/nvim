return {
    'folke/neodev.nvim',

    -- Visual
    {
        'norcalli/nvim-colorizer.lua',
        config = true,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },

    -- Snippet
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',

    -- LSP
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',

    -- 'dundalek/lazy-lsp.nvim'
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Others
    'lambdalisue/suda.vim',
    'tpope/vim-surround',
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
}
