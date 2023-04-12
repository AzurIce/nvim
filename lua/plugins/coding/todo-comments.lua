return {
    -- Highlights for todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        -- TODO: FIgure the commands and keymaps out
        -- stylua: ignore
        -- keys = {
        --     { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        --     { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        --     { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
        --     { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
        --     { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
        -- },
    },
}
