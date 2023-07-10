---@type (function)[]
local M = {}

---@return string, integer, integer
M.get_cword = function()
    local current_col = vim.api.nvim_win_get_cursor(0)[2]
    local cword --[[@type string]] = vim.fn.expand("<cword>")
    local line --[[@type string]] = vim.fn.getline(".")
    local line_len = string.len(line)

    local l = current_col + 1
    local r = current_col + 1

    ---@param char string
    ---@return boolean
    local function char_validate(char)
        return #char == 1
            and char ~= "."
            and char ~= ","
            and char ~= "+"
            and char ~= "-"
            and char ~= "="
            and char ~= "("
            and char ~= ")"
            and char ~= " "
    end

    while l > 1 or r < line_len do
        local s_l = true
        if l > 1 then
            s_l = char_validate(line:sub(l, l))
            if s_l then l = l - 1 end
        end

        local s_r = true
        if r < line_len then
            s_r = char_validate(line:sub(r, r))
            if s_r then r = r + 1 end
        end

        vim.notify(tostring(l + 1) .. " " .. tostring(r - 2))

        if not s_l and not s_r then return cword, l + 1, r - 2 end
    end

    return cword, l + 1, r - 2
end

---Alternative to vim.api.nvim_feedkeys
---@param keys string
---@param mode string
M.nvim_feedkeys = function(keys, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

return M
