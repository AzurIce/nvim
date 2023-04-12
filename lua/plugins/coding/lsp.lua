return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            'mason.nvim',
            'mason-lspconfig.nvim',
        },
        config = function()

        end
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        dependencies = {
            { 'folke/neodev.nvim', config = true },
        },
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
                -- ["lua_ls"] = function () -- server specific handler
                --     require("lspconfig").lua_ls.setup {
                --         capabilities = capabilities,
                --         settings = {
                --             Lua = {
                --                 completion = {
                --                     callSnippet = "Replace"
                --                 }
                --             }
                --         }
                --     }
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
