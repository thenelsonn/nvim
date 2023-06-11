local server_opts = require("thenelsonn.lsp.server-opts")
local jdtls_status, jdtls = pcall(require, "jdtls")
if not jdtls_status or not server_opts then
    return
end

-- $HOME
local home = os.getenv("HOME")

-- Root dir
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- Project name
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace = vim.fn.expand("~/.config/jdtls-workspace") .. project_name

-- nvim-jdtls configuration
local config = {
    cmd = {
        "java",

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        vim.fn.glob(home .. "/.local/share/nvim/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

        "-configuration",
        vim.fn.glob(home .. "/.local/share/nvim/jdtls/config_linux/"),

        "-data",
        workspace,
    },
    root_dir = root_dir,
    capabilities = server_opts.capabilities,
    signature_help = { enabled = true },
    on_attach = function(client, bufnr)
        server_opts.on_attach(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
    end,
    init_options = {
        bundles = {
            vim.fn.glob(
                home
                    .. "/.local/share/nvim/jdtls/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.46.0.jar",
                1
            ),
        },
    },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
