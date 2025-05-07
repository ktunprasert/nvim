local cmd = require("lib.utils").cmdcr

return {
    -- ███╗   ██╗ █████╗ ██╗   ██╗██╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
    -- ████╗  ██║██╔══██╗██║   ██║██║██╔════╝ ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
    -- ██╔██╗ ██║███████║██║   ██║██║██║  ███╗███████║   ██║   ██║██║   ██║██╔██╗ ██║
    -- ██║╚██╗██║██╔══██║╚██╗ ██╔╝██║██║   ██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
    -- ██║ ╚████║██║  ██║ ╚████╔╝ ██║╚██████╔╝██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
    -- ╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ~ Navigation
    {
        "chaoren/vim-wordmotion",
        -- lazy = false,
        event = "VeryLazy",
        init = function() vim.g.wordmotion_prefix = "<Space>" end
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        keys = {
            { mode = "n", "<Up>",   function() require("illuminate").goto_prev_reference(true) end, "Prev node under cursor" },
            { mode = "n", "<Down>", function() require("illuminate").goto_next_reference(true) end, "Next node under cursor" }
        },
        config = function()
            require("illuminate").configure({
                opts = 200,
                filetypes_denylist = {
                    'dirbuf',
                    'dirvish',
                    'fugitive',
                    'text',
                    'Avante', 'AvanteInput', 'AvanteSelectedFiles',
                },
                large_file_cutoff = 5000,
            })
        end
    },

    { "ThePrimeagen/harpoon", lazy = false, },
    {
        "mikavilpas/yazi.nvim",
        dependencies = {
            "folke/snacks.nvim",
        },
        keys = {
            { "<leader>f", cmd("Yazi"),        desc = "Yazi Reveal", mode = { "n", "v" }, },
            { "<A-r>",     cmd("Yazi toggle"), desc = "Yazi Toggle", },
            { "<A-e>",     cmd("Yazi cwd"),    desc = "Yazi CWD", },
        },
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
                open_file_in_vertical_split = "<a-l>",
                open_file_in_horizontal_split = "<a-j>",
                -- open_file_in_tab = "<c-t>",
                grep_in_directory = "<c-s>",
                replace_in_directory = "<a-s>",
                cycle_open_buffers = "<tab>",
                copy_relative_path_to_selected_files = "<c-y>",
                send_to_quickfix_list = "<c-q>",
                change_working_directory = "<c-.>",
            },

            integrations = {
                grep_in_directory = "snacks.picker",
                picker_add_copy_relative_path_action = "snacks.picker",
                -- TODO: WIP
                -- grep_in_selected_files = function(selected_files)
                --     print(selected_files)
                --     require("user.telescope.multigrep").live_multigrep({ extra_args = selected_files })
                -- end,
            },
        },
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            exclude = {
                "notify",
                "cmp_menu",
                "noice",
                "flash_prompt",
                "fastaction_popup",
                function(win)
                    -- exclude non-focusable windows
                    return not vim.api.nvim_win_get_config(win).focusable
                end,
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
                desc = "Flash global"
            },
        },
    }
}
