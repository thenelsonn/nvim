local nightfox_status, nightfox = pcall(require, "nightfox")
if not nightfox_status then
    vim.notify("Nightfox is not installed")
    return
end

nightfox.setup({
  options = {
    terminal_colors = true,
    transparent = true,
    styles = { 
      comments = "italic",
      conditionals = "italic",
      constants = "italic",
      functions = "italic",
      keywords = "italic",
      numbers = "italic",
      operators = "italic",
      strings = "italic",
      types = "italic",
      variables = "italic",
    },
  }
})

-- setup must be called before loading
vim.cmd("colorscheme nightfox")
