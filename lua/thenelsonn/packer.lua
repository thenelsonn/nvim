local packer_bootstrap = false
local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.notify("[Info]: Installing packer...")
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        path,
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

    use("nvim-treesitter/nvim-treesitter") -- treesitter configurations and abstraction layer for Neovim
    use("windwp/nvim-ts-autotag") -- auto close and auto rename html tag
    use("windwp/nvim-autopairs") -- auto pairs for neovim

    use("JoosepAlviste/nvim-ts-context-commentstring") -- set the commentstring based on the cursor pos in a file
    use("numToStr/Comment.nvim") -- smart and powerful commenting plugin for Neovim

    use("williamboman/mason.nvim") -- portable package manager
    use("neovim/nvim-lspconfig") -- configuration for Neovim's built-in LSP
    use("jose-elias-alvarez/null-ls.nvim") -- lsp diagnostics, code actions, formatting and more
    use("williamboman/mason-lspconfig.nvim") -- an extension for mason.nvim

    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-path") -- nvim-cmp source for path
    use("hrsh7th/cmp-calc") -- nvim-cmp source for math calculation
    use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
    use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for LSP
    use("hrsh7th/cmp-nvim-lua") -- nvim-cmp source for nvim lua
    use("saadparwaiz1/cmp_luasnip") -- nvim-cmp source for luasnip completion
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- nvim-cmp source for signature help

    use("rafamadriz/friendly-snippets") -- set of preconfigured snippets
    use("L3MON4D3/LuaSnip") -- snippet engine

    use("RRethy/vim-illuminate") -- auto highlight other uses of the word
    use("lewis6991/gitsigns.nvim") -- git integration
    use("nvim-lua/plenary.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        vim.notify("[Info]: Installing plugins...")
        vim.cmd("silent !nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'")
        vim.notify("[Info]: All set! Plugins will take effect upon your next visit")
    end
end)

return packer_bootstrap
