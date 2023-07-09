local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local servers = require("thenelsonn.mason.packages").list.lsp

-- setup servers
for _, server in pairs(servers) do
    local server_opts = require("thenelsonn.lsp.server-opts")
    local extra_opts_status, extra_opts = pcall(require, "thenelsonn.lsp.settings." .. server)
    if extra_opts_status then
        server_opts = vim.tbl_deep_extend("force", extra_opts, server_opts)
    end

    lspconfig[server].setup(server_opts)
end
