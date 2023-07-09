local M = {}

-- Path to the codelldb executable
local debugger_path = vim.fn.glob("~/.local/share/nvim/mason/packages/codelldb/codelldb")

-- Configuration for the codelldb adapter
local adapter = {
    type = "server",
    port = "${port}",
    executable = {
        command = debugger_path,
        args = { "--port", "${port}" },
    },
}

-- Configuration for debugging languages that
-- codelldb supports (c, cpp, rust)
local configuration = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
    },
}

--- A setup function for the `codelldb` debug adapter
--- and for debugging the languages it supports
M.setup = function(dap)
    dap.adapters["codelldb"] = adapter

    dap.configurations.c = configuration
    dap.configurations.cpp = configuration
    dap.configurations.rust = configuration
end

return M
