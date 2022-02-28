-----------------
-- LSP Install --
-----------------
local lsp_installer = require("nvim-lsp-installer")

local settings = {
    ["sumneko_lua"] = require("plugin-lsp.settings.lua")
}

for name, _ in pairs(settings) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
        print("Installing " .. name)
        server:install()
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == 'sumneko_lua' then
        opts = vim.tbl_deep_extend('force', settings[server.name], opts)
    end

    server:setup(opts)
end)
