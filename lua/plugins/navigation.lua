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
        "ggandor/leap.nvim",
        keys = {
            { mode = "n", "\\", "<Plug>(leap-forward-to)" },
            { mode = "n", "|",  "<Plug>(leap-backward-to)" },
        },
        opts = {
            labeled_modes = "v",
        },
        config = function(cfg)
            require("leap").setup(cfg.opts)

            do
                local group = vim.api.nvim_create_augroup("Leap", { clear = true })
                local smear = require('smear_cursor')
                vim.api.nvim_create_autocmd('User', {
                    group = group,
                    pattern = 'LeapEnter',
                    callback = function()
                        smear.toggle()
                    end,
                })
                vim.api.nvim_create_autocmd('User', {
                    group = group,
                    pattern = 'LeapLeave',
                    callback = function()
                        smear.toggle()
                    end,
                })


                vim.api.nvim_set_hl(0, 'LeapLabel', { fg = 'black', bg = "#D7A933" })
            end
        end,
    },
    {
        "ggandor/flit.nvim",
        dependencies = "ggandor/leap.nvim",
        keys = {
            { 'f' }, { 'F' }, { 't' }, { 'T' },
        },
        opts = {
            keys = { f = 'f', F = 'F', t = 't', T = 'T' },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "nx",
            multiline = true,
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {
                max_highlighted_traversal_targets = 10,
            }
        },
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
                large_file_cutoff = 1000,
            })
        end
    },

    { "ThePrimeagen/harpoon", lazy = false, },
    {
        "mikavilpas/yazi.nvim",
        dependencies = {
            "folke/snacks.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>f", cmd("Yazi"),        desc = "Open yazi at the current file", mode = { "n", "v" }, },
            { "<A-r>",     cmd("Yazi toggle"), desc = "Resume the last yazi session", },
            { "<A-e>",     cmd("Yazi cwd"),    desc = "Yazi in current workdir", },
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
                grep_in_directory = function(directory)
                    require("user.telescope.multigrep").live_multigrep({ extra_args = { directory } })
                end,
                -- TODO: WIP
                -- grep_in_selected_files = function(selected_files)
                --     print(selected_files)
                --     require("user.telescope.multigrep").live_multigrep({ extra_args = selected_files })
                -- end,
            },
        },
    }
}
