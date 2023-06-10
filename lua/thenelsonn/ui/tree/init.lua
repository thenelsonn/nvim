local tree_status, tree = pcall(require, "nvim-tree")
if not tree_status then
    return
end

-- load custom keymappings
local remap = require("thenelsonn.ui.tree.remap")

tree.setup({
    disable_netrw = true,
    on_attach = remap.on_attach,
    renderer = {
        group_empty = true,
    },
})
