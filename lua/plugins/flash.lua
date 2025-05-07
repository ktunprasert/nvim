return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
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
                style = "inline",
            },
            modes = {
                char = {
                    keys = { "f", "F", "t", "T" },
                    char_actions = function(motion)
                        return {
                            [";"] = "next",
                            [","] = "prev",
                            [motion:lower()] = "next",
                            [motion:upper()] = "prev",
                        }
                    end,
                    jump_labels = true,
                },
            },
        },
        keys = {
            { "\\",    mode = { "n", "x", "o" }, function() require("flash").jump() end,                               desc = "Flash" },
            { "|",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,                         desc = "Flash Treesitter" },
            { "gr",    mode = "o",               function() require("flash").remote() end,                             desc = "Remote Flash" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,                             desc = "Toggle Flash Search" },
            { "gt",    mode = { "o", "x" },      function() require("flash").treesitter_search({ pattern = "." }) end, desc = "Treesitter Search" },
            -- emulate hop stuff
            {
                "<c-space>1",
                function() require("flash").jump({ continue = true }) end,
                desc = "Flash continue"
            },
            {
                "<c-space>t",
                function()
                    require("flash").treesitter({})
                end,
                desc = "Flash treesitter"
            },
        },
        config = function(cfg)
            require("flash").setup(cfg.opts)

            local Flash = require("flash")

            local function format(opts)
                -- always show first and second label
                return {
                    { opts.match.label1, "FlashLabel" },
                    { opts.match.label2, "FlashLabel" },
                }
            end

            local fn =
                function()
                    Flash.jump({
                        search = { mode = "search" },
                        label = { style = "overlay", after = false, before = { 0, 0 }, uppercase = false, format = format },
                        pattern = [[\<]],
                        action = function(match, state)
                            state:hide()
                            Flash.jump({
                                search = { max_length = 0 },
                                highlight = { matches = false },
                                label = { format = format },
                                matcher = function(win)
                                    -- limit matches to the current label
                                    return vim.tbl_filter(function(m)
                                        return m.label == match.label and m.win == win
                                    end, state.results)
                                end,
                                labeler = function(matches)
                                    for _, m in ipairs(matches) do
                                        m.label = m.label2 -- use the second label
                                    end
                                end,
                            })
                        end,
                        labeler = function(matches, state)
                            local labels = state:labels()
                            for m, match in ipairs(matches) do
                                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                                match.label2 = labels[(m - 1) % #labels + 1]
                                match.label = match.label1
                            end
                        end,
                    })
                end

            vim.keymap.set("n", "<C-space><C-space>", fn)
        end,

    }
}
