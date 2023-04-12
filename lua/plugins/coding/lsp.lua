return {
    {
        'neovim/nvim-lspconfig',
        -- event = { "BufReadPre", "BufNewFile", "BufAdd" },
        dependencies = {
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            'mason-lspconfig.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'williamboman/mason.nvim', config = true },
        },
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
                -- ["lua_ls"] = function () -- server specific handler
                --     require("lspconfig").lua_ls.setup {
                --         capabilities = capabilities,
                -- end
            }
        end
    },

}
