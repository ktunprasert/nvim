local flash_util = require("lib.flash_util")

local menus = {
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
    },
    fns = {
        function() flash_util.flash_word() end,
        function() require("flash").jump() end,
        function() require("flash").remote() end,
        function() require("flash").treesitter({}) end,
        function() require("flash").treesitter_search() end,
        function() require("flash").jump({ continue = true }) end,
        function() require("multicursor-nvim").matchAllAddCursors() end,
        function() require("multicursor-nvim").searchAllAddCursors() end,
        function() require("multicursor-nvim").restoreCursors() end,
        function() require("multicursor-nvim").matchAddCursor(-1) end,
        function() require("multicursor-nvim").matchAddCursor(1) end,
        function() require("multicursor-nvim").operator() end,
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

local override = function(params)
    if params.kind == "actions" then
        if menus.keys[params.title] ~= nil then
            return { key = menus.keys[params.title] }
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
                        menus.items,
                        { prompt = 'Actions', kind = "actions", },
                        function(_, idx) menus.fns[idx]() end
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
