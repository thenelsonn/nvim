local dap_status, dap = pcall(require, "dap")
if not dap_status then
    return
end

dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
                source_filetype = "python",
            },
        })
    else
        cb({
            type = "executable",
            command = "python3",
            args = { "-m", "debugpy.adapter" },
            options = {
                source_filetype = "python",
            },
        })
    end
end

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Debug",
        program = "${file}",
    },
}
