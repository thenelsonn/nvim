local bufferline_status, bufferline = pcall(require, "bufferline")
if not bufferline_status then return end

bufferline.setup({
    options = {
        mode = "tabs",
        numbers = "ordinal",
        close_icon = "󰅖",
        buffer_close_icon = "󰅖",
        modified_icon = " ",
        left_trunc_marker = " ",
        right_trunc_marker = " ",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
    },
})
