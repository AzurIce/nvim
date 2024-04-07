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
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        lazy = false,
        config = true, -- TODO: do more configurations here
    },
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

              syntax = false,            -- enable syntax highlighting, affects performance

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
    },

    {
      "epwalsh/obsidian.nvim",
      version = "*",  -- recommended, use latest release instead of latest commit
      lazy = true,
      ft = "markdown",
      -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
      -- event = {
      --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      --   "BufReadPre path/to/my-vault/**.md",
      --   "BufNewFile path/to/my-vault/**.md",
      -- },
      dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
      },
      opts = {
        workspaces = {
          {
            name = "Notes",
            path = "~/Notes",
          },
        },

        -- see below for full list of options 👇
      },
    }
}
