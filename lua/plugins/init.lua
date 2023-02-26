return {
    'folke/lazy.nvim',

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
