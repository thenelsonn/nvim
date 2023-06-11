local ui_status, ui = pcall(require, "dapui")
if not ui_status then
    return
end

local sidebar = {
    size = 40,
    position = "right",
    elements = {
        { id = "scopes", size = 0.5 },
        { id = "watches", size = 0.5 },
    },
}

local footer = {
    size = 10,
    position = "bottom",
    elements = {
        { id = "console", size = 1 },
    },
}

ui.setup({
    layouts = {
        sidebar,
        footer,
    },
})

-- connect dap-ui and dap to work together
local dap_status, dap = pcall(require, "dap")
if not dap_status then
    return
end

dap.listeners.after.event_initialized["dapui_config"] = ui.open
dap.listeners.before.event_terminated["dapui_config"] = ui.close
dap.listeners.before.event_exited["dapui_config"] = ui.close
