-- Set keymap so you can open the default terminal file manager (yazi)
local tfm = require("tfm")

tfm.setup({
    enable_cmds = true,
    ui = {
        width = 0.8,
        height = 0.8,
    },
})

vim.keymap.set("n", "<leader>wy", function()
    tfm.open()
end)
