local dap_status, dap = pcall(require, "dap")
if not dap_status then
    return
end

-- keymaps
local opts = { noremap = true, silent = false }
local keymap = vim.keymap.set

keymap("n", "<F5>", dap.continue, opts)
keymap("n", "<F9>", dap.terminate, opts)
keymap("n", "<F10>", dap.step_over, opts)
keymap("n", "<F11>", dap.step_into, opts)
keymap("n", "<F12>", dap.step_out, opts)
keymap("n", "<leader>b", dap.toggle_breakpoint, opts)
keymap("n", "<leader>B", dap.set_breakpoint, opts)
