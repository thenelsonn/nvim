local M = {}

local Package_status, Package = pcall(require, "mason-core.package")
local registry_status, registry = pcall(require, "mason-registry")
if not Package_status or not registry_status then
    return
end

M.list = {
    lsp = {
        "tsserver",
        "cssmodules_ls",
        "rust_analyzer",
        "pyright",
        "jsonls",
        "cssls",
        "lua_ls",
        "cmake",
        "html",
        "bashls",
        "clangd",
    },
    dap = {
        "codelldb",
        "debugpy",
        "java-debug-adapter",
        "js-debug-adapter",
    },
    linter = {},
    formatter = {
        "cmakelang",
        "clang-format",
        "prettierd",
        "stylua",
    },
    other = {
        "jdtls",
    },
}

local function install(package, version)
    vim.notify(("[mason.nvim]: Installing %s"):format(package.name))
    package:install({ version = version }):once(
        "closed",
        vim.schedule_wrap(function()
            if package:is_installed() then
                vim.notify(("[mason.nvim]: Installed - %s"):format(package.name))
            else
                vim.notify(("[mason.nvim]: Failed - %s"):format(package.name), vim.log.levels.ERROR)
            end
        end)
    )
end

function M.ensure()
    registry.refresh(vim.schedule_wrap(function()
        for group, packages in pairs(M.list) do
            if group ~= "lsp" then
                for _, name in ipairs(packages) do
                    local package_name, version = Package.Parse(name)
                    local status, package = pcall(registry.get_package, package_name)
                    if status then
                        if not package:is_installed() then
                            install(package, version)
                        end
                    else
                        vim.notify(("[mason.nvim]: %s is not a valid package name"):format(name), vim.log.levels.WARN)
                    end
                end
            else
                local lspconfig_status, lspconfig = pcall(require, "mason-lspconfig")
                if lspconfig_status then
                    lspconfig.setup({
                        ensure_installed = packages,
                    })
                end
            end
        end
    end))
end

return M
