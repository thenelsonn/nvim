local options = {
    clipboard = "unnamedplus", -- sync (Neo)vim with the system clipboard
    updatetime = 300, -- after this many milliseconds flush swap file
    timeoutlen = 300, -- time out time in milliseconds
    mouse = "a", -- enable mouse
    -- indenting & formatting -----------------------------------------------------
    smarttab = true, -- use shiftwidth when inserting <Tab>
    smartcase = true, -- no ignore case when pattern has uppercase
    smartindent = true, -- smart autoindenting
    expandtab = true, -- use spaces when <Tab> is inserted
    softtabstop = 4, -- number of spaces that <Tab> uses while editing
    shiftwidth = 4, -- number of spaces to use for (auto)indent step
    tabstop = 4, -- number of spaces that <Tab> in file uses
    wrap = false, -- display each line in the single row
    -- window ---------------------------------------------------------------------
    number = true, -- show current line number
    relativenumber = true, -- show relative line numbers in front of each line
    numberwidth = 4, -- number of columns used for the line number
    splitright = true, -- force vertical splits to the right side of current window
    splitbelow = true, -- force hotizontal splits below current window
    cmdheight = 1, -- number of lines to use for the command-line
    pumheight = 30, -- maximum number of items to show in the popup menu
    showmode = false, -- don't show current mode on status line
    cursorline = true, -- highlight the screen line of the cursor
    signcolumn = "yes", -- display the sign column
    scrolloff = 8, -- minimum nr. of lines above and below cursor
    sidescrolloff = 8, -- min nr. of columns to left and right of cursor
    termguicolors = true, -- enable terminal colors
    -- file -----------------------------------------------------------------------
    fileencoding = "utf-8", -- file encoding for multibyte text
    encoding = "utf-8", -- encoding used internally
    undofile = true, -- save undo information in a file
    swapfile = false, -- don't use a swapfile for a buffer
    backup = false, -- don't keep backup file after overwriting a file
    writebackup = false, -- don't make a backup before overwriting a file
    -- search ---------------------------------------------------------------------
    ignorecase = true,
    hlsearch = true,
}

-- Netrw
vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0

-- Disable Providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

for key, value in pairs(options) do
    vim.opt[key] = value
end
