local M = {}

-- Path to the Javascript/Typescript debugger
local debugger_path = vim.fn.glob("~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js")

-- Configuration for the the Javascript/Typescript debug adapter
local adapter = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = {
            debugger_path,
            "${port}",
        },
    },
}

-- Configuration for debugging Javascript code
local configuration_js = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**" },
    },
}

-- Configuration for debugging Typescript code
local configuration_ts = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        runtimeArgs = { "-r", "ts-node/register" },
        skipFiles = { "<node_internals>/**" },
    },
}

--- A setup function for `js-debug-adapter`
--- and for debugging the languages it supports
M.setup = function(dap)
    dap.adapters["pwa-node"] = adapter

    dap.configurations.javascript = configuration_js
    dap.configurations.typescript = configuration_ts
end

return M
