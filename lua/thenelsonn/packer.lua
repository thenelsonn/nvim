local packer_bootstrap = false
local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.notify("[Info]: Installing packer...")
    vim.fn.system({
        "git",
        "clone",
        "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        path
    })

    vim.cmd("packadd packer.nvim")
    packer_bootstrap = true
end

local packer = require("packer")
packer.startup(function(use)
    use("wbthomason/packer.nvim") -- let packer.nvim manage itself

    use("martinsione/darkplus.nvim") -- a dark Neovim theme ported from VS Code

    use("nvim-tree/nvim-web-devicons") -- icon pack
    use("nvim-lualine/lualine.nvim") -- custom status line for Neovim
    use("goolord/alpha-nvim") -- neovim greeter

    use("nvim-telescope/telescope-file-browser.nvim") -- extension for telescope.nvim
    use("nvim-telescope/telescope.nvim") -- highly extendable fuzzy finder

    use("nvim-lua/plenary.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        vim.notify("[Info]: Installing plugins...")
        vim.cmd("silent !nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'")
        vim.notify("[Info]: All set! Plugins will take effect upon your next visit")
    end
end)

return packer_bootstrap
