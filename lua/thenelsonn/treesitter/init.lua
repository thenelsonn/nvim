local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
    return
end

-- list of required TS parsers
local parsers = {
    "cpp",
    "tsx",
    "lua",
    "java",
    "bash",
    "yaml",
    "json",
    "html",
    "cmake",
    "jsdoc",
    "luadoc",
    "python",
    "haskell",
    "typescript",
    "javascript",
    "markdown_inline",
    "markdown",
}

treesitter.setup({
    auto_install = true,
    sync_install = false,
    ensure_installed = parsers,
    indent = { enable = true, disable = {} },
    highlight = { enable = true, disable = {} },
})

-- setup everything else
require("thenelsonn.treesitter.autopairs")
require("thenelsonn.treesitter.autotag")
require("thenelsonn.treesitter.comment")
