return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")

        vim.keymap.set({"i"}, "<C-f>", function() ls.expand() end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-g>", function() ls.jump( 1) end, {silent = true})
        require("luasnip.loaders.from_lua").load({paths = "./snippets"})
        require("luasnip.loaders.from_lua").load({paths = "~/.snippets"})
    end
}

