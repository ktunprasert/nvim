return {
    -- ███╗   ██╗ █████╗ ██╗   ██╗██╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
    -- ████╗  ██║██╔══██╗██║   ██║██║██╔════╝ ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
    -- ██╔██╗ ██║███████║██║   ██║██║██║  ███╗███████║   ██║   ██║██║   ██║██╔██╗ ██║
    -- ██║╚██╗██║██╔══██║╚██╗ ██╔╝██║██║   ██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
    -- ██║ ╚████║██║  ██║ ╚████╔╝ ██║╚██████╔╝██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
    -- ╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ~ Navigation
    {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function() require("user.plugins.hop") end
    },
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
        config = function(opts)
            require("leap").setup(opts)

            do
                local smear = require('smear_cursor')
                vim.api.nvim_create_autocmd('User', {
                    pattern = 'LeapEnter',
                    callback = function()
                        smear.toggle()
                    end,
                })
                vim.api.nvim_create_autocmd('User', {
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
        after = "ggandor/leap.nvim",
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
        event = "BufRead",
        keys = {
            { mode = "n", "<Up>",   function() require("illuminate").goto_prev_reference(true) end, "Prev node under cursor" },
            { mode = "n", "<Down>", function() require("illuminate").goto_next_reference(true) end, "Next node under cursor" }
        },
        init = function()
            require("illuminate").configure({
                opts = 200,
                filetypes_denylist = {
                    'dirbuf',
                    'dirvish',
                    'fugitive',
                    'text',
                },

            })
        end
    },

    { "ThePrimeagen/harpoon", lazy = false, },
    {
        "jinh0/eyeliner.nvim",
        event = "BufRead",
        priority = 999,
        config = function() require("user.plugins.eyeliner") end
    },
}
