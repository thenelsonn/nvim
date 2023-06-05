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

    use("EdenEast/nightfox.nvim") -- a highly customizable theme with support for a variety of plugins
    use("LunarVim/darkplus.nvim") -- a dark Neovim theme ported from VS Code Dark+ theme

    use("nvim-tree/nvim-web-devicons") -- icon pack
    use("nvim-lualine/lualine.nvim") -- custom status line for Neovim

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        vim.notify("[Info]: Installing plugins...")
        vim.cmd("silent !nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'")
        vim.notify("[Info]: All set! Plugins will take effect upon your next visit")
    end
end)

return packer_bootstrap
