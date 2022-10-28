-----------------
-- LSP Install --
-----------------
-- require("nvim-lsp-installer").setup {
--     automatic_installation = true
-- }

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
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

require('lazy-lsp').setup {
  -- By default all available servers are set up. Exclude unwanted or misbehaving servers.
  -- excluded_servers = {
  --   "ccls", "zk",
  -- },
  -- Default config passed to all servers to specify on_attach callback and other options.
  default_config = {
    -- flags = {
    --   debounce_text_changes = 150,
    -- },
    on_attach = on_attach,
    capabilities = capabilities,
  },
  -- Override config for specific servers that will passed down to lspconfig setup.
  configs = {
    -- sumneko_lua = {
    --   cmd = {"lua-language-server"},
    --   -- on_attach = on_lua_attach,
    --   -- capabilities = capabilities,
    -- },
    sumneko_lua = require("azurice.plugin-lsp.settings.lua")
  },
}

-- local lspconfig = require("lspconfig")
-- 
-- local lspSettings = {
--     ["clangd"] = {},
--     ["jdtls"] = {},
--     ["pyright"] = {},
--     ["rust_analyzer"] = {},
--     ["sumneko_lua"] = require("azurice.plugin-lsp.settings.lua")
-- }
-- 
-- for key, value in pairs(lspSettings) do
--     lspconfig[key].setup {
--         on_attach = on_attach,
--         capabilities = capabilities,
--         settings = value
--     }
-- end
