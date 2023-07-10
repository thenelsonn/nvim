local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.notify("Packer is not installed! See README.md", vim.log.levels.WARN)
    return false
end

vim.cmd("packadd packer.nvim")
local packer = require("packer")

packer.init({
    autoremove = true,
    ensure_dependencies = true,
    display = { prompt_border = "single" },
})

packer.startup(function(use)
    use("wbthomason/packer.nvim") -- let packer.nvim manage itself

    use("martinsione/darkplus.nvim") -- a dark Neovim theme ported from VS Code

    use("nvim-tree/nvim-web-devicons") -- icon pack
    use("nvim-lualine/lualine.nvim") -- custom status line for Neovim
    use("goolord/alpha-nvim") -- neovim greeter

    use("nvim-telescope/telescope.nvim") -- highly extendable fuzzy finder

    use("nvim-treesitter/nvim-treesitter") -- treesitter configurations and abstraction layer for Neovim
    use("windwp/nvim-ts-autotag") -- auto close and auto rename html tag
    use("windwp/nvim-autopairs") -- auto pairs for neovim

    use("JoosepAlviste/nvim-ts-context-commentstring") -- set the commentstring based on the cursor pos in a file
    use("numToStr/Comment.nvim") -- smart and powerful commenting plugin for Neovim

    use("mfussenegger/nvim-dap") -- debug adapter protocol client implementation
    use("rcarriga/nvim-dap-ui") -- a ui for nvim-dap

    use("mxsdev/nvim-dap-vscode-js") -- nvim-dap adapter for vscode-js-debug

    use("williamboman/mason.nvim") -- portable package manager
    use("neovim/nvim-lspconfig") -- configuration for Neovim's built-in LSP
    use("jose-elias-alvarez/null-ls.nvim") -- lsp diagnostics, code actions, formatting and more
    use("williamboman/mason-lspconfig.nvim") -- an extension for mason.nvim
    use("mfussenegger/nvim-jdtls") -- extensions for the built-in LSP for eclipse.jdt.ls

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

    use("lukas-reineke/indent-blankline.nvim") -- indent guides for Neovim
    use("lewis6991/gitsigns.nvim") -- git integration
    use("RRethy/vim-illuminate") -- auto highlight other uses of the word
    use("nvim-lua/plenary.nvim")

    -- Markdown preview plugin for Neovim
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
end)

return true
