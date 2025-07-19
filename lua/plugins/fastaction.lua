local flash_util = require("lib.flash_util")

Menus = {
    items = {
        " hop",
        " jump",
        " remote",
        " treesitter",
        " treesitter search",
        " continue",
        "󰇀 all <cword>",
        "󰇀 all search term",
        "󰇀 restore",
        "󰇀 prev match",
        "󰇀 next match",
        "󰇀 operator in range",
        " buffer pick",
    },
    fns = {
        function() flash_util.flash_word() end,
        function() require("flash").jump() end,
        function() require("flash").remote() end,
        function() require("flash").treesitter({}) end,
        function() require("flash").treesitter_search() end,
        function() require("flash").jump({ continue = true }) end,
        function() require("multicursor-nvim").matchAllAddCursors() end,
        function()
            vim.ui.input(
                { prompt = "Search term: ", default = vim.fn.expand("<cword>") },
                function(input)
                    if input ~= nil and input ~= "" then
                        vim.fn.setreg('/', input)
                        require("multicursor-nvim").searchAllAddCursors()
                    else
                        require("multicursor-nvim").matchAllAddCursors()
                    end
                end
            )
        end,
        function() require("multicursor-nvim").restoreCursors() end,
        function() require("multicursor-nvim").matchAddCursor(-1) end,
        function() require("multicursor-nvim").matchAddCursor(1) end,
        function() require("multicursor-nvim").operator() end,
        function() return vim.cmd("BufferLinePick") end,
    },
    keys = {
        [" hop"] = "<C-Space>",
        [" jump"] = "j",
        ["󰇀 all <cword>"] = "m",
        ["󰇀 all search term"] = "s",
        ["󰇀 restore"] = "v",
        ["󰇀 prev match"] = "N",
        ["󰇀 next match"] = "n",
        ["󰇀 operator (iwap)"] = "S",
    },
}

Menus.append = function(item, fn, key)
    if item ~= nil and fn ~= nil then
        table.insert(Menus.items, item)
        table.insert(Menus.fns, fn)
    end

    if key ~= nil then
        Menus.keys[item] = key
    end
end

local override = function(params)
    if params.kind == "actions" then
        if Menus.keys[params.title] ~= nil then
            return { key = Menus.keys[params.title] }
        end
    end
end


return {
    {
        'Chaitanyabsprip/fastaction.nvim',
        dependencies = { "jake-stewart/multicursor.nvim" },
        keys = {
            { "<F3>", function() require("fastaction").code_action() end, mode = { "v", "n" } },
            {
                "<c-space>",
                function()
                    vim.ui.select(
                        Menus.items,
                        { prompt = 'Actions', kind = "actions", },
                        function(_, idx) Menus.fns[idx]() end
                    )
                end,
                mode = { "n", "v" },
            },
        },
        opts = {
            dismiss_keys = { "j", "k", "<c-c>", "q", "<Esc>" },
            register_ui_select = true,
            override_function = override,
            priority = {
                go = {
                    { pattern = "organize import", key = "o", order = 1 },
                },
            },
            popup = {
                relative = "cursor",
                highlight = {
                    action = "",
                    key = "AshenRedFlame",
                },
            },
            -- format_right_section = function(item)
            --     if item.ctx ~= nil then
            --         return vim.lsp.get_client_by_id(item.ctx.client_id).name
            --     end
            -- end,
        },
    },

}
