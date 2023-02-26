return {
    {
        'neovim/nvim-lspconfig',
        lazy = true,
        dependencies = {
            { 'folke/neodev.nvim', config = true },
            'mason-lspconfig.nvim',
        },
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        dependencies = { 'mason.nvim' },
        cmd = { 'LspInstall', 'LspUninstall' },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls' },
            })
            require("mason-lspconfig").setup_handlers {
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                -- ["rust_analyzer"] = function () -- server specific handler
                --     require("rust-tools").setup {}
                -- end
            }
        end
    },
    {
        'williamboman/mason.nvim',
        lazy = true,
        config = true,
    },
}
