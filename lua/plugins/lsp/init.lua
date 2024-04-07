return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { "folke/neodev.nvim", opts = { } }, -- for vim lua
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "mason.nvim" },
                config = function()
                    require("mason-lspconfig").setup({
                        ensure_installed = { "lua_ls", "rust_analyzer" },
                        automatic_installation = true,
                    })
                end 
            },
        },
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup{}
            lspconfig.clangd.setup{}
        end
    },

}
