local dap_status, dap = pcall(require, "dap")
if not dap_status then
    return { dap_status, dap }
end

require("thenelsonn.dap.config.node").setup(dap)
require("thenelsonn.dap.config.debugpy").setup(dap)
require("thenelsonn.dap.config.codelldb").setup(dap)

return { dap_status, dap }
