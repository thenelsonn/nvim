local api_status, api = pcall(require, "nvim-tree.api")
if not api_status then
    return {}
end

local M = {}
M.on_attach = function(bufnr)
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    local keymap = vim.keymap.set
    local opts = {
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
    }

    keymap("n", "c", api.fs.create, opts)
    keymap("n", "r", api.fs.rename, opts)
    keymap("n", "d", api.fs.remove, opts)
    keymap("n", "x", api.fs.cut, opts)
    keymap("n", "s", api.fs.copy.node, opts)
    keymap("n", "p", api.fs.paste, opts)
end

local keymap = vim.keymap.set
local opts = {
    noremap = true,
    silent = true,
}

keymap("n", "<leader>eo", api.tree.open, opts)
keymap("n", "<leader>eq", api.tree.close, opts)

-- open and find the current node
keymap("n", "<leader>ef", function()
    api.tree.open({ find_file = true })
end, opts)

return M
