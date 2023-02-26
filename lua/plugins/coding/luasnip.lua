return {
    {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        dependencies = { 'friendly-snippets' },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    { 'rafamadriz/friendly-snippets', lazy = true }
}
