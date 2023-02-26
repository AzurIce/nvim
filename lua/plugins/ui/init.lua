require'azurice.utils'

local plugins = {}

table.merge(plugins, require'plugins.ui.colorscheme')
table.merge(plugins, require'plugins.ui.bufferline')
table.merge(plugins, require'plugins.ui.lualine')
table.merge(plugins, require'plugins.ui.nvim-tree')

return plugins
