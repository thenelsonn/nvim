local telescope_status, telescope = pcall(require, "telescope")
local builtin_status, builtin = pcall(require, "telescope.builtin")
if not telescope_status or not builtin_status then
    return
end

telescope.setup({
    defaults = {
        theme = "dropdown",
        prompt_prefix = "  ",
        respect_gitignore = true,
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        path_display = { "smart" },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_config = {
            width = 0.6,
            height = 0.6,
            horizontal = {
                prompt_position = "top"
            },
        },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true
        },
    },
})

telescope.load_extension("file_browser")
local browser = telescope.extensions.file_browser

vim.keymap.set("n", "<space>w", function()
    builtin.find_files({
        prompt_title = "",
        results_title = "",
        previewer = false
    })
end)

vim.keymap.set("n", "<space>e", function()
    browser.file_browser({
        prompt_title = "",
        previewer = false
    })
end)
