---@type table
local M = {}

local nvim = require("thenelsonn.utilities.nvim")
local lang = require("thenelsonn.utilities.lang")
local win = require("thenelsonn.utilities.win")

M.nvim_feedkeys = nvim.nvim_feedkeys
M.get_cword = nvim.get_cword
M.ternary = lang.ternary
M.Window = win.Window

return M
