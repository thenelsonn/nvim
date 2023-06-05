require("thenelsonn.set")
require("thenelsonn.remap")   

-- Set up the dependent plugins only after 
-- configuring the plugin manager.
if not require("thenelsonn.packer") then
    require("thenelsonn.treesitter")
    require("thenelsonn.colors")
    require("thenelsonn.ui")
end
