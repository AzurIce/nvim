-----------------
-- LSP Install --
-----------------
local function lsp_highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
              augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup END
        ]], false)
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gl",
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-F6>', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
end

local function on_attach(client, bufnr)
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    end
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local fn = vim.fn

if not fn.has('win32') then
    require('lazy-lsp').setup {
      default_config = {
        on_attach = on_attach,
        capabilities = capabilities,
      },
      configs = {
        sumneko_lua = require("azurice.plugin-lsp.settings.lua")
      },
    }
else
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { 'lua_ls' },
    })
    require'neodev'.setup()
    require'lspconfig'.lua_ls.setup{}        -- Lua
    require'lspconfig'.gopls.setup{}         -- Golang
    require'lspconfig'.rust_analyzer.setup{} -- Rust
    require'lspconfig'.cmake.setup{}         -- CMake
    require'lspconfig'.clangd.setup{}        -- C/C++

    require'lspconfig'.cssls.setup{}         -- CSS
    require'lspconfig'.cssmodules_ls.setup{  -- CSS modules
        capabilities = capabilities
    }

    require'lspconfig'.denols.setup{}        -- Deno
    require'lspconfig'.eslint.setup({        -- ESLint
        on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end,
    })

    require'lspconfig'.glslls.setup{}        -- GLSL

    require'lspconfig'.gradle_ls.setup{}     -- Gradle
    require'lspconfig'.html.setup {          -- HTML
        capabilities = capabilities,
    }
    require'lspconfig'.java_language_server.setup{}   -- Java
    -- require'lspconfig'.jdtls.setup{}
    require'lspconfig'.kotlin_language_server.setup{} -- Kotlin
    require'lspconfig'.pyright.setup{}                -- Python
    require'lspconfig'.yamlls.setup {                 -- YAML
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    ["../path/relative/to/file.yml"] = "/.github/workflows/*",
                    ["/path/from/root/of/project"] = "/.github/workflows/*",
                },
            },
        }
    }

    require'lspconfig'.texlab.setup{}               -- (La)Tex
    -- require'lspconfig'.tsserver.setup{}          -- TypeScript

end
