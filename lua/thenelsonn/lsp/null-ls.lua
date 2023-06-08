local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
    return
end

local formatting = null_ls.builtins.formatting

local lsp = vim.lsp
local api = vim.api

local function on_attach(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        api.nvim_clear_autocmds({ buffer = bufnr })
        api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                lsp.buf.format()
            end,
        })
    end
end

null_ls.setup({
    on_attach = on_attach,
    debug = false,
    sources = {
        formatting.clang_format.with({ extra_args = { "-style={IndentWidth: 4}" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "4" } }),
        formatting.mdformat.with({ extra_args = { "--wrap", "85" } }),
        formatting.cmake_format.with({ extra_args = { "--tab-size", "4" } }),
        formatting.prettierd,
        formatting.rustfmt,
    },
})
