require("thenelsonn.set")
require("thenelsonn.remap")
require("thenelsonn.utils")

-- Set up the dependent plugins only after
-- configuring the plugin manager.
if not require("thenelsonn.packer") then
    require("thenelsonn.ui")
    require("thenelsonn.colors")
    require("thenelsonn.treesitter")

    require("thenelsonn.cmp")
    require("thenelsonn.lsp")

    require("thenelsonn.plugins")
end
