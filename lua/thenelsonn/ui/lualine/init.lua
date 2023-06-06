local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
    return
end

local C = require("thenelsonn.ui.lualine.components")

lualine.setup({
    options = {
        theme = "auto",
        component_separators = {},
        section_separators = {},
        disabled_filetypes = {
            "alpha",
            "dashboard",
        },
    },
    sections = {
        lualine_a = { C.bar },
        lualine_b = { C.filetype, C.filename },
        lualine_c = { C.diagnostics },
        lualine_x = { C.LSP },
        lualine_y = { C.branch, C.diff },
        lualine_z = { C.bar },
    },
    inactive_sections = {
        lualine_a = { C.bar },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { C.bar },
    },
})
