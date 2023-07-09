local M = {}

-- Path to the debugpy executable
local debugger_path = vim.fn.glob("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

-- Configuration for the `debugpy` debug adapter
local adapter = {
    type = "executable",
    command = debugger_path,
    options = { source_filetype = "python" },
    args = { "-m", "debugpy.adapter" },
}

-- Configuration for debugging python code
local configuration = {
    {
        type = "debugpy",
        name = "Debug",
        request = "launch",
        program = "${file}",
        console = "integratedTerminal",
    },
}

--- A setup function for the `debugpy` debug adapter
--- and python debugging configuration
M.setup = function(dap)
    dap.adapters["debugpy"] = adapter
    dap.configurations.python = configuration
end

return M
