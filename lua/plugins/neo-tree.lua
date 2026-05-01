-- Workaround: Neo-tree 3.40 registers a BufModifiedSet autocmd that
-- can fail on certain Neovim nightly builds when sourced via rocks.nvim.
-- We monkey-patch the event registration to skip it.
local events = require("neo-tree.events")
local orig_define = events.define_autocmd_event
events.define_autocmd_event = function(event_name, autocmds, ...)
    if event_name == events.VIM_BUFFER_MODIFIED_SET then
        return
    end
    return orig_define(event_name, autocmds, ...)
end

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

