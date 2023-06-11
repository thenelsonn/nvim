local dap_status, dap = pcall(require, "dap")
if not dap_status then
    return
end

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "Debug",
        type = "codelldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
    },
}

-- apply same config for c and rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.c
