require('bufferline').setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon' -- 'icon' | 'underline' | 'none'
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc"
        diagnostics_update_in_insert = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = "NvimTree", -- "File Explorer" | function
                text_align = "center", -- "left" | "center" | "right"
            }
        },
        show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
        -- enforce_regular_tabs = true,
        always_show_bufferline = true,
        -- hover = {
        --     enabled = true,
        --     delay = 200,
        --     reveal = {'close'}
        -- },
        sort_by = 'insert_after_current' -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
    }
}
