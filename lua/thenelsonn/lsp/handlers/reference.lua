local window = {}
window.winr = nil
window.opts = {
    relative = "cursor",
    style = "minimal",
    title = "References",
    title_pos = "left",
    border = "single",
    width = 50,
    height = 10,
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

-- Apply a handler to the 'textDocument/references' request
vim.lsp.handlers["textDocument/references"] = vim.lsp.with(function(_, result, ctx, _)
    if not result or vim.tbl_isempty(result) then
        return
    end
    local encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
    local items = vim.lsp.util.locations_to_items(result, encoding)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local lines = {}

    local max_filename_width = 0
    for _, item in pairs(items) do
        local croppedName = item.filename:match("([^/]+)$")
        max_filename_width = math.max(max_filename_width, croppedName:len())
    end

    local max_width = 0
    for _, item in ipairs(items) do
        local line = item.filename:match("([^/]+)$") .. " | " .. item.text:gsub("^%s*(.-)%s*$", "%1")
        max_width = math.max(max_width, vim.api.nvim_strwidth(line))
        table.insert(lines, line)
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

    window.winr = vim.api.nvim_open_win(bufnr, true, window.opts)
    vim.api.nvim_win_set_option(window.winr, "cursorline", true)

    -- key mappings
    local opts = { buffer = bufnr, noremap = true, silent = true }
    local keymap = vim.keymap.set

    keymap({ "n", "i" }, "q", function()
        window.close(window)
    end, opts)
    keymap({ "n", "i" }, "<Esc>", function()
        window.close(window)
    end, opts)
    keymap({ "n", "i" }, "<CR>", function()
        local cursor = vim.api.nvim_win_get_cursor(0)[1]
        local item = items[cursor]
        if item == nil then
            return
        end
        local location = {
            uri = "file://" .. item.filename,
            range = {
                start = {
                    line = item.lnum - 1,
                    character = item.col - 1,
                },
            },
        }

        -- jump to reference
        window.close(window)
        vim.lsp.util.jump_to_location(location, encoding)
    end, opts)
end, {})
