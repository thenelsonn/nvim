---@type (function)[]
local M = {}

---A ternary operator for the Lua language
---@param cond boolean
---@param T any
---@param F any
---@return boolean
M.ternary = function(cond, T, F)
    if cond then
        return T
    else
        return F
    end
end

return M
