-- load colorschemes
require("thenelsonn.colors")

-- For transparency
local groups = {
    "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
    "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
    "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
    "SignColumn", "CursorLineNr", "EndOfBuffer",
}

-- list all available colorschemes
-- in the current Neovim configuration
local colorschemes = vim.fn.getcompletion("", "color")

--- Open the cache file that stores 
--- the most recently used colorscheme
--- @param flags integer|string
--- @return integer|nil
local function fs_open(flags)
    local fd, err = vim.loop.fs_open(vim.fn.stdpath("data") .. "/last_color", flags, 438)
    if err then
        return nil
    end
    return fd
end

--- Retrieve the last colorscheme
--- @return string|nil colorscheme
local function retrieve_colorscheme()
    local fd = fs_open("r")
    if not fd then
        return nil
    end

    local size = assert(vim.loop.fs_fstat(fd)).size
    local data = assert(vim.loop.fs_read(fd, size, -1))

    assert(vim.loop.fs_close(fd))

    local colorscheme, _ = data:gsub("[\n\r]", "")
    return colorscheme
end

--- Remove all background colors to make nvim transparent
local function remove_background()
    for _, v in ipairs(groups) do
        local attrs = vim.tbl_extend("force", vim.api.nvim_get_hl_by_name(v, true), { bg = "none", ctermbg = "none" })
        attrs[true] = nil
        vim.api.nvim_set_hl(0, v, attrs)
    end
end

-- Remember the colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(info)
        local colorscheme = info.match
        if not vim.tbl_contains(colorschemes, colorscheme) then
            return nil
        end

        local fd = fs_open("w")
        if not fd then
            return
        end

        assert(vim.loop.fs_write(fd, ("%s\n"):format(colorscheme), -1))
        assert(vim.loop.fs_close(fd))

        remove_background()
    end,
})

local colorscheme = retrieve_colorscheme()
if colorscheme then
    vim.cmd("colorscheme " .. colorscheme)
end

remove_background()
