require("thenelsonn.set")
require("thenelsonn.remap")

-- Set up the dependent plugins only after 
-- configuring the plugin manager.
if not require("thenelsonn.packer") then
    require("thenelsonn.colors")
end

