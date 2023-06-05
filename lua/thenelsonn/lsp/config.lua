local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
local mason_status, mason = pcall(require, "mason")
if not (mason_status or lspconfig_status or mason_lspconfig_status) then
    return
end

-- list of required LSP servers
local servers = {
    "rust_analyzer",
    "cssmodules_ls",
    "tsserver",
    "pyright",
    "clangd",
    "jsonls",
    "lua_ls",
    "bashls",
    "cssls",
    "cmake",
    "html",
}

-- setup mason.nvim
mason.setup({})
mason_lspconfig.setup({
    ensure_installed = servers,
})

-- setup servers
for _, server in pairs(servers) do
    local server_opts = require("thenelsonn.lsp.server-opts")
    local extra_opts_status, extra_opts = pcall(require, "thenelsonn.lsp.settings." .. server)
    if extra_opts_status then
        server_opts = vim.tbl_deep_extend("force", extra_opts, server_opts)
    end

    lspconfig[server].setup(server_opts)
end
