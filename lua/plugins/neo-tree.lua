require("neo-tree").setup({
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    source_selector = {
        winbar = true,
        statusline = false,
    },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
    },
    window = {
        mappings = {
            ["<space>"] = "none",
            ["<cr>"] = {
                "toggle_node",
                nowait = false,
            },
            ["o"] = "open",
        },
    },
    default_component_configs = {
        indent = {
            with_expanders = true,
        },
    },
})

vim.keymap.set('', '<leader>te', function()
    require("neo-tree.command").execute({
        toggle = true,
        source = "filesystem",
        position = "left"
    })
end)

