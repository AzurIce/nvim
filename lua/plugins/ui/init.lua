return {
    require'plugins.ui.colorscheme',
    require'plugins.ui.bufferline',
    require'plugins.ui.lualine',
    require'plugins.ui.nvim-tree',

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
}
