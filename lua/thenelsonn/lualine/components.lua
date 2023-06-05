local M = {}

M.bar = {
    padding = 0,
    function()
        return " "
    end
}

M.filetype = {
    "filetype",
    icon_only = true,
    colored = false,
}

M.filename = {
    "filename",
    color = { gui = "bold" }
}

M.diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
}

M.LSP = {
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = " ",
    color = { gui = "bold" },
    padding = { left = 1, right = 2 }
}

M.branch = {
    "branch",
    icon = " ",
    color = { gui = "bold" },
}

M.diff = {
    "diff",
    symbols = { 
        added = " ", 
        modified = " ", 
        removed = " " 
    }
}

return M
