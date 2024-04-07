local is_picking_focus = require('cokeline.mappings').is_picking_focus
local is_picking_close = require('cokeline.mappings').is_picking_close
local get_hex = require('cokeline.hlgroups').get_hl_attr

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3

require('cokeline').setup({
    show_if_buffers_are_at_least = 0,
    default_hl = {
        fg = function(buffer)
            return
                buffer.is_focused
                and get_hex('Normal', 'fg')
                or get_hex('Comment', 'fg')
        end,
        bg = function() return get_hex('ColorColumn', 'bg') end,
    },
    components = {
        {
            text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
        },
        {
            text = '  ',
        },
        {
            text = function(buffer)
                return
                    (is_picking_focus() or is_picking_close())
                    and buffer.pick_letter .. ' '
                    or buffer.devicon.icon
            end,
            fg = function(buffer)
                return
                    (is_picking_focus() and yellow)
                    or (is_picking_close() and red)
                    or buffer.devicon.color
            end,
            italic = function()
                return
                    (is_picking_focus() or is_picking_close())
            end,
            bold = function()
                return
                    (is_picking_focus() or is_picking_close())
            end
        },
        { -- filename
            text = function(buffer)
                return buffer.filename
            end,
            underline = function(buffer)
                if buffer.is_hovered and not buffer.is_focused then
                    return true
                end
            end,
        },
        {
            text = ' ',
        },
        {
            ---@param buffer Buffer
            text = function(buffer)
                if buffer.is_modified then
                    return ""
                end
                if buffer.is_hovered then
                    return "󰅙"
                end
                return "󰅖"
            end,
            on_click = function(_, _, _, _, buffer)
                buffer:delete()
            end,
        },
        {
            text = " ",
        },
    },
})

vim.keymap.set("n", "<leader>q", function()
    local buffer_id = vim.api.nvim_get_current_buf()
    vim.api.nvim_command("bn")
    vim.api.nvim_command("bdelete " .. buffer_id)
end, { silent = true })
vim.keymap.set("n", "<leader>b", function()
    require('cokeline.mappings').pick("focus")
end, { desc = "Pick a buffer to focus" })
vim.keymap.set("n", "<leader>h", "<Plug>(cokeline-focus-prev)", { silent = true })
vim.keymap.set("n", "<leader>l", "<Plug>(cokeline-focus-next)", { silent = true })
