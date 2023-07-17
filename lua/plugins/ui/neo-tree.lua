return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({
                        toggle = true,
                        source = "filesystem",
                        position = "left"
                    })
                end,
                desc = "NeoTree (filesystem)",
            },
        },
        opts = {
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
        },
    },
}
