local luasnip_status, luasnip = pcall(require, "luasnip")
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status or not luasnip_status then
    return
end

-- load luasnip
require("luasnip.loaders.from_vscode").lazy_load()

local fn = require("thenelsonn.cmp.funcs")
local src = require("thenelsonn.cmp.sources")

cmp.setup({
    completion = {},
    preselect = cmp.PreselectMode.None,
    snippet = { expand = fn.expand(luasnip) },
    sources = cmp.config.sources(src),
    formatting = fn.formatting,
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = fn.tab(cmp, luasnip),
        ["<S-Tab>"] = fn.stab(cmp, luasnip),
    }),
})
