local ts_comment_status, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
local comment_status, comment = pcall(require, "Comment")
if not comment_status or not ts_comment_status then
  return
end

comment.setup {
    padding = true,
    sticky = true,
    ignore = nil,
    opleader = { line = "ec", block = "eb" },
    toggler = { line = "ecc", block = "ebc" },
    pre_hook = ts_comment.create_pre_hook()
}
