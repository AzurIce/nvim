-- plugin-cmp
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local cmp = require'cmp'
cmp.setup({
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    },
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<ESC>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<TAB>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' }
    })
})

-- 设置命令补全源
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    })
})

-- 设置搜索补全源
cmp.setup.cmdline('/', {
    sources = cmp.config.sources({
        { name = 'buffer' }
    })
})

------------
-- Visual --
------------
-- gray
vim.cmd('highlight!CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
-- blue
vim.cmd('highlight!CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
vim.cmd('highlight!CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
-- light blue
vim.cmd('highlight!CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight!CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight!CmpItemKindText guibg=NONE guifg=#9CDCFE')
-- pink
vim.cmd('highlight!CmpItemKindFunction guibg=NONE guifg=#C586C0')
vim.cmd('highlight!CmpItemKindMethod guibg=NONE guifg=#C586C0')
-- front
vim.cmd('highlight!CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
vim.cmd('highlight!CmpItemKindProperty guibg=NONE guifg=#D4D4D4')
vim.cmd('highlight!CmpItemKindUnit guibg=NONE guifg=#D4D4D4')
