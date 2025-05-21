local cmd = require("lib.utils").cmdcr

return {
    -- ███╗   ██╗ █████╗ ██╗   ██╗██╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
    -- ████╗  ██║██╔══██╗██║   ██║██║██╔════╝ ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
    -- ██╔██╗ ██║███████║██║   ██║██║██║  ███╗███████║   ██║   ██║██║   ██║██╔██╗ ██║
    -- ██║╚██╗██║██╔══██║╚██╗ ██╔╝██║██║   ██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
    -- ██║ ╚████║██║  ██║ ╚████╔╝ ██║╚██████╔╝██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
    -- ╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ~ Navigation
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
            { "<A-e>",     cmd("Yazi toggle"), desc = "Yazi Toggle", },
        },
        opts = {
            yazi_floating_window_winblend = winblend(),
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
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            { "w",     "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "x" } },
            { "e",     "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "x" } },
            { "b",     "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "x" } },
            { "<C-f>", "<cmd>lua require('spider').motion('w')<CR>", mode = { "i" } },
            { "<C-b>", "<cmd>lua require('spider').motion('b')<CR>", mode = { "i" } },
            { "<C-e>", "<cmd>lua require('spider').motion('e')<CR>", mode = { "i" } },
        },
    },
}
