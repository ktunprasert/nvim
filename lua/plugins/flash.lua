return {
    {
        "folke/flash.nvim",
        lazy = true,
        opts = {
            search = {
                exclude = {
                    "notify",
                    "cmp_menu",
                    "noice",
                    "flash_prompt",
                    "fastaction_popup",
                    "snacks_notif",
                    function(win)
                        -- exclude non-focusable windows
                        return not vim.api.nvim_win_get_config(win).focusable
                    end,
                },
            },
            jump = {
                autojump = true,
            },
            label = {
                rainbow = {
                    enable = true,
                },
            },
            modes = {
                char = {
                    enabled = false,
                    -- keys = { "f", "F", "t", "T" },
                    -- char_actions = function(motion)
                    --     return {
                    --         [";"] = "next",
                    --         [","] = "prev",
                    --         [motion:lower()] = "next",
                    --         [motion:upper()] = "prev",
                    --     }
                    -- end,
                    -- jump_labels = true,
                },
            },
        },
        keys = {
            { "\\",    mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
            { "|",     mode = "n",               function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "gT",    mode = { "x", "o" },      function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "gr",    mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
            {
                "gt",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search({
                        pattern =
                        "."
                    })
                end,
                desc = "Treesitter Search"
            },
        },
    }
}
