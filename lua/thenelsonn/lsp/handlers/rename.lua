-- Apply a handler to the 'textDocument/rename' request
vim.lsp.handlers["textDocument/rename"] = vim.lsp.with(function(_, result, ctx, _)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)

    local column = vim.api.nvim_win_get_cursor(0)[1]
    local _, _, row = _G.Utils.get_cword()

    vim.api.nvim_win_set_cursor(0, { column, row - 1 })
end, {})

-- window object
local window = {}
window.winr = nil

-- rename window props
window.opts = {
    relative = "cursor",
    style = "minimal",
    border = "single",
    title = "Rename",
    title_pos = "left",
    width = 30,
    height = 1,
    row = 0,
    col = 0,
}

function window:close()
    local insert = false
    if vim.api.nvim_get_mode().mode == "i" then
        insert = true
        vim.cmd([[stopinsert]])
    end

    -- close the rename window
    vim.api.nvim_win_close(self.winr, true)

    local e_winr_col = vim.api.nvim_win_get_cursor(0)[1]
    local _, row_s, _ = _G.Utils.get_cword()

    -- move cursor to the beginning of the word
    vim.api.nvim_win_set_cursor(0, { e_winr_col, row_s - _G.Utils.ternary(insert, 0, 1) })
end

vim.lsp.buf.rename_ui = function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    if char == "" or char == " " then
        return
    end

    local e_winr_col = vim.api.nvim_win_get_cursor(0)[1]
    local cword, row_s, _ = _G.Utils.get_cword()

    -- move the cursor to the beginning of the word
    vim.api.nvim_win_set_cursor(0, { e_winr_col, row_s - 1 })

    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { cword })

    window.winr = vim.api.nvim_open_win(bufnr, true, window.opts)
    if window.winr then
        vim.cmd([[normal! V]])
        _G.Utils.nvim_feedkeys("<C-g>", "n")
    end

    -- keymaps
    local opts = { buffer = bufnr, noremap = true, silent = true }
    local keymap = vim.keymap.set

    keymap({ "n" }, "q", function()
        window.close(window)
    end, opts)
    keymap({ "i", "n" }, "<esc>", function()
        window.close(window)
    end, opts)
    keymap({ "i", "n" }, "<cr>", function()
        local n = vim.fn.getline(".")
        window.close(window)
        vim.lsp.buf.rename(n)
    end, opts)
end
