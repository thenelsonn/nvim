local illuminate_status, illuminate = pcall(require, "illuminate")
local lsp_status, lsp = pcall(require, "cmp_nvim_lsp")
if not illuminate_status or not lsp_status then
    return
end

local s_opts = {}

-- executes whenever a language server
-- is attached to a buffer
s_opts.on_attach = function(client, bufnr)
    illuminate.on_attach(client)

    -- disable default formatting provider
    client.server_capabilities.documentFormattingProvider = false

    -- buffer local mappings
    local opts = { buffer = bufnr, noremap = true, silent = true }
    local keymap = vim.keymap.set

    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "gf", vim.lsp.buf.format, opts)
    keymap("n", "gr", vim.lsp.buf.rename_ui, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gh", vim.lsp.buf.code_action, opts)
    keymap("n", "gI", vim.lsp.buf.implementation, opts)
    keymap("n", "gn", vim.diagnostic.goto_next, opts)
    keymap("n", "gN", vim.diagnostic.goto_prev, opts)
    keymap("n", "gl", vim.diagnostic.open_float, opts)
    keymap("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    keymap("n", "<Space>gr", vim.lsp.buf.references, opts)
end

-- set up completion using nvim_cmp with LSP source
s_opts.capabilities = lsp.default_capabilities()
s_opts.capabilities.offsetEncoding = { "utf-16" }

return s_opts
