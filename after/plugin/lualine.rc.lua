local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then return end

local bar = {
    padding = 0,
    function() return " " end,
}

lualine.setup({
    options = {
        theme = "auto",
        component_separators = {},
        section_separators = {},
        disabled_filetypes = {
            "alpha",
            "dashboard",
            "NvimTree",
        },
    },
    sections = {
        lualine_a = { bar },
        lualine_b = {
            {
                "filetype",
                icon_only = true,
                colored = false,
            },
            {
                "filename",
                color = { gui = "bold" },
            },
        },
        lualine_c = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " " },
            },
        },
        lualine_x = {
            {
                function()
                    local msg = "No Active Lsp"
                    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then return msg end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
                    end
                    return msg
                end,
                icon = " ",
                color = { gui = "bold" },
                padding = { left = 1, right = 2 },
            },
        },
        lualine_y = {
            {
                "branch",
                icon = " ",
                color = { gui = "bold" },
            },
            {
                "diff",
                symbols = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
            },
        },
        lualine_z = { bar },
    },
    inactive_sections = {
        lualine_a = { bar },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { bar },
    },
})
