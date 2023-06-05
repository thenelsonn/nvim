-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Set up diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
})

-- Customize the appearance of the diagnostics float
vim.diagnostic.config({
    float = { source = "always", border = "single" },
})