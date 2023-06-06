local icons = require("thenelsonn.cmp.icons")
local M = {}

--- nvim-cmp <Tab> key map handler
M.tab = function(cmp, luasnip)
    return function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expandable() then
            luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end
end

--- nvim-cmp <S-Tab> key map handler
M.stab = function(cmp, luasnip)
    return function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end
end

--- setup Luasnip
M.expand = function(luasnip)
    return function(args)
        luasnip.lsp_expand(args.body)
    end
end

--- Autocompletion menu formatting
M.formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, item)
        item.kind = string.format("%s", icons[item.kind])
        item.menu = ({
            nvim_lsp_signature_help = "[SH]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            luasnip = "[Luasnip]",
            buffer = "[Buffer]",
            calc = "[Math]",
            path = "[Path]",
        })[entry.source.name]
        return item
    end,
}

return M
