-- Apply a handler to the 'textDocument/hover' request
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(function(_, result, ctx, config)
    if not (result and result.contents) then return end

    config = config or {}
    config.focus_id = ctx.method

    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then return end

    return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", { border = config.border })
end, { border = "single" })
