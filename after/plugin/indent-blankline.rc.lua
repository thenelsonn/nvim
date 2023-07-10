local blankline_status, blankline = pcall(require, "indent_blankline")
if not blankline_status then
    return
end

blankline.setup({})
