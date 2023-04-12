return {
    'folke/lazy.nvim',

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

    -- Others
    'lambdalisue/suda.vim',
    'tpope/vim-surround',
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup() -- TODO: figure this out
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
