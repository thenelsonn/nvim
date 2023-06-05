_G.Utils = {}

--- returns information about
--- the word under the user's cursor
--- @diagnostic disable-next-line
Utils.get_cword = function()
    local cword = vim.fn.expand("<cword>")
    local line = vim.fn.getline(".")
    local row_s, row_e = string.find(line, cword)
    return cword, row_s, row_e
end

--- alternative to vim.api.nvim_feedkeys
--- @diagnostic disable-next-line
Utils.nvim_feedkeys = function(keys, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

--- ternary operator for Lua
--- @diagnostic disable-next-line
Utils.ternary = function(cond, T, F)
    if cond then
        return T
    else
        return F
    end
end
