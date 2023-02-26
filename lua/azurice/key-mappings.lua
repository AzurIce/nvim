local keymap = vim.api.nvim_set_keymap
local fn = vim.fn
local opt = vim.opt

---------------
-- Keymaping --
---------------
keymap('c', 'w!!', ':SudaWrite', {})
keymap('', 's', '<nop>', {})
keymap('', 'S', ':w<CR>', {})
keymap('', 'Q', ':q<CR>', {})
keymap('', 'R', ':source $MYVIMRC<CR>', {})
-- keymap('', 'R', ':luafile init.lua<CR>', {})

keymap('', 'J', '7j', {noremap = true})
keymap('', 'K', '7k', {noremap = true})
keymap('', 'H', '<nop>', {})
keymap('', 'H', '0', {noremap = true})
keymap('', 'L', '<nop>', {})
keymap('', 'L', '$', {noremap = true})

-- keymap('v', '<Tab>', '>gv', {noremap = true})
-- keymap('v', '<S-Tab>', '<gv', {noremap = true})

keymap('n', '<C-a>', 'gg<S-v>G', {noremap = true})
keymap('v', '<C-c>', '"+y', {noremap = true})

-- Windowing
keymap('n', '<C-s>h', ':vsplit<CR>', {})         -- Ctrl + Shift + h: split left
keymap('n', '<C-s>j', ':split<CR><C-j>', {})     -- Ctrl + Shift + j: split down
keymap('n', '<C-s>k', ':split<CR>', {})          -- Ctrl + shift + k: split up
keymap('n', '<C-s>l', ':vsplit<CR><C-l>', {})    -- Ctrl + shift + k: split right
keymap('n', '<C-h>', '<C-w>h', {noremap = true})
keymap('n', '<C-j>', '<C-w>j', {noremap = true})
keymap('n', '<C-k>', '<C-w>k', {noremap = true})
keymap('n', '<C-l>', '<C-w>l', {noremap = true})

-- keymap('i', '<C-j>', 'v:lua.require\'cmp\'.scroll_docs(-4)', {noremap = true})
-- keymap('i', '<C-k>', 'v:lua.require\'cmp\'.scroll_docs(4)', {noremap = true})

keymap('n', '<C-A-j>', ':resize -2<CR>', {noremap = true})
keymap('n', '<C-A-k>', ':resize +2<CR>', {noremap = true})
keymap('n', '<C-A-h>', ':vertical resize -2<CR>', {noremap = true})
keymap('n', '<C-A-l>', ':vertical resize +2<CR>', {noremap = true})
-- Buffer and Tab
-- keymap('n', '<C-Tab>', '<nop>', {})
-- keymap('n', '<C-Tab>', 'v:count!=0? ":<C-u>" . v:count . "tabn<CR>" : ":tabn<CR>"', {noremap = true, expr = true})
keymap('n', '<C-,>', ':bprevious<CR>', {})
keymap('n', '<C-.>', ':bnext<CR>', {})
keymap('n', '<C-/>', ':bdelete<CR>', {})

keymap('n', '<C-[>', ':tabp<CR>', {})
keymap('n', '<C-]>', ':tabn<CR>', {})
keymap('n', '<C-\\>', ':tabclose<CR>', {})
keymap('n', '<C-n>', ':tabe<CR>', {noremap = true})

-- Jumping
-- keymap('n', '<C-]>', 'gf', {noremap = true})
-- keymap('n', '<C-[>', ':e#<CR>', {noremap = true})

-- Useful little things
-- keymap('', '<C-S-J>', 'ddp', {noremap = true})
-- keymap('', '<C-S-K>', 'ddkkp', {noremap = true})

-------------
-- Compile --
-------------
keymap('n', '<LEADER>c', ':call v:lua.Compile()<CR>', {noremap = true})
function Compile()
    vim.cmd[[
        exec 'w'
        if &filetype == 'c'
            if has('win32')
                exec '!clang -target x86_64-pc-windows-gnu "%" -o "%<"'
            else
                exec '!gcc "%" -o "%<"'
            endif
        elseif &filetype == 'cpp'
            if has('win32')
                exec '!clang++ -target x86_64-pc-windows-gnu "%" -o "%<"'
            else
                exec '!g++ "%" -o "%<"'
            endif
        elseif &filetype == 'markdown'
            exec 'MarkdownPreview'
        endif
    ]]
end