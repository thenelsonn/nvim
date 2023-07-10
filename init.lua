require("thenelsonn.set")
require("thenelsonn.remap")

-- Set up the dependent plugins only after
-- configuring the plugin manager.
if require("thenelsonn.packer") then
    require("thenelsonn.colors")

    require("thenelsonn.mason")

    require("thenelsonn.cmp")
    require("thenelsonn.lsp")
    require("thenelsonn.dap")
end
