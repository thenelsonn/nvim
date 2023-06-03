--- Install packer with git
function install_packer(install_path)
    vim.notify("\nInstalling plugin manager...")
    vim.fn.system({
        "git",
        "clone",
        "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
end

local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.notify("Plugin manager is not installed")
    local input = vim.fn.input("Install now? (y)/n: ")
    if input == "" or input == "y" then
        install_packer(path)
        vim.notify("Plugin manager was successfully installed!")
        vim.fn.input("Press 'Enter' and re-open Neovim")
        vim.cmd("q!") -- quit Neovim
    else vim.cmd("q!") end
end

vim.cmd.packadd("packer.nvim")
return require("packer").startup(function(use)
    use("wbthomason/packer.nvim") -- let packer.nvim manage itself

    use("LunarVim/darkplus.nvim") -- A dark Neovim theme ported from VS Code Dark+ theme.
end)
