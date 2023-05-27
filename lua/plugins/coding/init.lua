require'azurice.utils'

local plugins = {}

table.merge(plugins, require'plugins.coding.nvim-treesitter')
table.merge(plugins, require'plugins.coding.lsp')
table.merge(plugins, require'plugins.coding.cmp')
table.merge(plugins, require'plugins.coding.luasnip')
table.merge(plugins, require'plugins.coding.nvim-autopairs')
table.merge(plugins, require'plugins.coding.todo-comments')
table.merge(plugins, require'plugins.coding.vim-illuminate')

return plugins
