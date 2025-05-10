local flash_util = require("lib.flash_util")

local menus = {
    items = {
        " hop",
        " treesitter",
        " treesitter search",
        " continue",
    },
    fns = {
        function() flash_util.flash_word() end,
        function() require("flash").treesitter({}) end,
        function() require("flash").treesitter_search() end,
        function() require("flash").jump({ continue = true }) end,
    },
}


return {
    {
        'Chaitanyabsprip/fastaction.nvim',
        keys = {
            { "<F3>", function() require("fastaction").code_action() end, mode = { "v", "n" } },
            {
                "<c-space>",
                function()
                    vim.ui.select(menus.items, { prompt = 'Actions', },
                        function(choice, idx)
                            menus.fns[idx]()
                        end)
                end,
            },
        },
        opts = {
            dismiss_keys = { "j", "k", "<c-c>", "q", "<Esc>" },
            register_ui_select = true,
            -- override_function = function()end, -- TODO: implement a "number-first" key quick jump
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
        },
    },

}
