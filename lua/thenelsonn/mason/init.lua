local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

mason.setup({
    pip = { upgrade_pip = true },
    ui = {
        check_outdated_packages_on_open = true,
        border = "single",
        width = 0.8,
        height = 0.9,
        icons = {
            package_installed = "󰘾 ",
            package_pending = " ",
            package_uninstalled = "󰬸 ",
        },
    },
})

local packages = require("thenelsonn.mason.packages")
packages.ensure()
