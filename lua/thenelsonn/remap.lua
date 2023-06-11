local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- new leader
vim.g.mapleader = " "

-- split window
keymap("n", "sh", "<cmd>split<cr>", opts)
keymap("n", "sv", "<cmd>vsplit<cr>", opts)

-- better navigation across visible panes
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)

-- move lines in the visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- pend the lines below to the current line
-- and keep your cursor in the same place
keymap("n", "J", "mzJ`z")

-- jump across the current file
-- and keep the cursor in the middle
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- jump across the current file
-- and keep the search terms in the middle
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- clear search-highlighting
keymap("n", "<C-r>", "<cmd>nohlsearch<cr>", opts)

-- replace and keep the previous buffer
keymap("x", "<leader>p", '"_dP', opts)

-- jump to the previous file
keymap("n", "<C-o>", "<C-^>", opts)

-- open the current pane in new tab
keymap("n", "<leader>o", "<cmd>tabnew %<cr>", opts)
