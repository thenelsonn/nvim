local telescope_status, telescope = pcall(require, "telescope")
local builtin_status, builtin = pcall(require, "telescope.builtin")
if not telescope_status or not builtin_status then
    return
end

telescope.setup({
    defaults = {
        theme = "dropdown",
        results_title = "",
        prompt_prefix = "  ",
        selection_caret = "  ",
        respect_gitignore = true,
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        path_display = { "smart" },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_config = {
            width = 0.6,
            height = 0.6,
            horizontal = {
                prompt_position = "top",
            },
        },
    },
})

-- open Telescope
vim.keymap.set("n", "<space>w", function()
    builtin.find_files({
        previewer = false,
    })
end)
