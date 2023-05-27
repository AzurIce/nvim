return {
    {
        'nvim-treesitter/nvim-treesitter',
        config = function ()
            require'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all" (the four listed parsers should always be installed)
                ensure_installed = { "c", "cpp", "lua", "vim", "markdown", "html", "css", "go", "rust", "python" },

                sync_install = false,
                auto_install = true,

                ignore_install = {},

                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                      init_selection = "gnn", -- set to `false` to disable one of the mappings
                      node_incremental = "grn",
                      scope_incremental = "grc",
                      node_decremental = "grm",
                    },
                },
                indent = {
                    enable = true
                }
            }

            vim.cmd[[
            function FoldConfig()
                set foldmethod=expr
                set foldexpr=nvim_treesitter#foldexpr()
                set nofoldenable
            endfunction
            ]]
            --
            -- autocmd BufAdd,BufEnter,BufNew,BufNewFile,BufWinEnter * :call FoldConfig()
            -- ]]
        end,
        build = ":TSUpdate"
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
}
