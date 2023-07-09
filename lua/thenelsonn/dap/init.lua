local config = require("thenelsonn.dap.config")
local ui_status, ui = pcall(require, "dapui")
if not config[1] or not ui_status then
    return
end

local dap = config[2]

-- Keymaps ------------------------------------------------------------

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<F5>", dap.continue, opts)
keymap("n", "<F9>", dap.terminate, opts)
keymap("n", "<F10>", dap.step_over, opts)
keymap("n", "<F11>", dap.step_into, opts)
keymap("n", "<F12>", dap.step_out, opts)
keymap("n", "<leader>b", dap.toggle_breakpoint, opts)
keymap("n", "<leader>B", dap.set_breakpoint, opts)

keymap("n", "<F6>", ui.open, opts)
keymap("n", "<F7>", ui.close, opts)

-- Events -------------------------------------------------------------

dap.listeners.after.event_initialized["dapui_config"] = ui.open
dap.listeners.before.event_terminated["dapui_config"] = ui.close
dap.listeners.before.event_exited["dapui_config"] = ui.close

-- UI -----------------------------------------------------------------

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
