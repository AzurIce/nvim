return {
    'folke/lazy.nvim',

    -- Visual
    {
        'norcalli/nvim-colorizer.lua',
        config = true,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },

    -- Others
    'lambdalisue/suda.vim',
    'tpope/vim-surround',
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup() -- TODO: figure this out
            require 'azurice.key-mappings'
        end
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },

    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        config = function()
            require('peek').setup({
              auto_load = true,         -- whether to automatically load preview when
                                        -- entering another markdown buffer
              close_on_bdelete = true,  -- close preview window on buffer delete

              syntax = true,            -- enable syntax highlighting, affects performance

              theme = 'dark',           -- 'dark' or 'light'

              update_on_change = true,

              app = 'chromium',          -- 'webview', 'browser', string or a table of strings
                                        -- explained below

              filetype = { 'markdown' },-- list of filetypes to recognize as markdown

              -- relevant if update_on_change is true
              throttle_at = 200000,     -- start throttling when file exceeds this
                                        -- amount of bytes in size
              throttle_time = 'auto',   -- minimum amount of time in milliseconds
                                        -- that has to pass before starting new render
            })
        end
    }
}
