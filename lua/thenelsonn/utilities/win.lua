local M = {}

---@class Window
---@field winr any
---@field opts WindowOpts

---@class WindowOpts
---@field relative string
---@field style string
---@field border string
---@field title string
---@field title_pos string
---@field width number
---@field height number
---@field row number
---@field col number

---@class Window
local Window = {
    winr = nil,
    opts = {
        relative = "cursor",
        style = "minimal",
        border = "single",
        title = "Rename",
        title_pos = "left",
        width = 30,
        height = 1,
        row = 0,
        col = 0,
    },
}

---Display the window to a user
---@param bufnr any
---@param enter boolean
function Window:open(bufnr, enter) self.winr = vim.api.nvim_open_win(bufnr, enter, self.opts) end

---Close the current instance
function Window:close() vim.api.nvim_win_close(self.winr, true) end

---Window constructor
---@param o Window | nil
---@return Window
function Window:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

M.Window = Window

return M
