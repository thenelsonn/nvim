local utils = require("thenelsonn.utilities")

-- Apply a handler to the 'textDocument/rename' request
vim.lsp.handlers["textDocument/rename"] = vim.lsp.with(function(_, result, ctx, _)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)

    local row = vim.api.nvim_win_get_cursor(0)[1]
    local _, _, column_e = utils.get_cword()

    vim.api.nvim_win_set_cursor(0, { row, column_e })
end, {})

vim.lsp.buf.rename_ui = function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    if char == "" or char == " " then return end

    local e_winr_row = vim.api.nvim_win_get_cursor(0)[1]
    local cword, col_s, _ = utils.get_cword()

    -- move the cursor to the beginning of the word
    vim.api.nvim_win_set_cursor(0, { e_winr_row, col_s })

    local window = utils.Window:new()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { cword })
    window:open(bufnr, true)
    if window.winr then
        vim.cmd([[normal! V]])
        utils.nvim_feedkeys("<C-g>", "n")
    end

    -- keymaps
    local opts = { buffer = bufnr, noremap = true, silent = true }
    local keymap = vim.keymap.set

    keymap({ "n" }, "q", function() window:close() end, opts)
    keymap({ "i", "n" }, "<esc>", function() window:close() end, opts)
    keymap({ "i", "n" }, "<cr>", function()
        local n = vim.fn.getline(".")
        window:close()

        if vim.api.nvim_get_mode().mode == "i" then vim.cmd([[stopinsert]]) end
        if #n > 0 then vim.lsp.buf.rename(n) end
    end, opts)
end
