require("thenelsonn.set")
require("thenelsonn.remap")

-- Set up the dependent plugins only after
-- configuring the plugin manager.
if require("thenelsonn.packer") then
    require("thenelsonn.treesitter")
    require("thenelsonn.colors")
    require("thenelsonn.ui")

    require("thenelsonn.mason")

    require("thenelsonn.cmp")
    require("thenelsonn.lsp")
    require("thenelsonn.dap")

    require("thenelsonn.plugins")
end
