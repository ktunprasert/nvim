local cmd = require("lib.utils").cmdcr
return {
    "folke/which-key.nvim",
    opts = {
        preset = "helix",
        notify = false,
        plugins = {
            marks = true,     -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = true,                            -- adds help for operators like d, y, ...
                motions = true,                              -- adds help for motions
                text_objects = true,                         -- help for text objects triggered after entering an operator
                windows = true,                              -- default bindings on <c-w>
                nav = true,                                  -- misc bindings to work with windows
                z = true,                                    -- bindings for folds, spelling and others prefixed with z
                g = true,                                    -- bindings for prefixed with g
            },
            spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
        },
        win = {
            no_overlap = true,
            height = { min = 4, max = 25 },
            padding = { 0, 1 }, -- extra window padding [top/bottom, right/left]
            title = true,
            title_pos = "center",
            zindex = 1000,
            wo = { winblend = winblend() },
        },
        layout = {
            height = { min = 4, max = 25 },  -- min and max height of the columns
            width = { min = 20, max = 100 }, -- min and max width of the columns
            spacing = 3,                     -- spacing between columns
            align = "center",                -- align columns left, center or right
        },
        filter = function() return true end,
        triggers = { { "<auto>", mode = "nxso" }, },
        spec = {
            { "<Leader>", group = "Power Mode", },
            {
                group = "[Code]",
                icon = "//",
                {
                    "<Leader>c",
                    -- disgusting that they haven't fixed this by now
                    "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
                    desc = "Comment",
                    mode = { "v" },
                },
                {
                    "<Leader>c",
                    "<Esc><Cmd>lua require('Comment.api').toggle.linewise()<CR>",
                    desc = "Comment",
                },
                {
                    "<Leader>F",
                    cmd("Format"),
                    desc = "Format current file",
                },
            },
            {
                group = "[Dependencies]",
                { "<Leader>l", cmd("Lazy"),  desc = "Lazy",  icon = "LZ" },
                { "<Leader>m", cmd("Mason"), desc = "Mason", icon = "MS" },
            },
            {
                group = "[External]",
                { "<Leader>G", desc = "LazyGit", icon = "LG" },
            },
            {
                group = "[Window]",
                { "<A-g>", cmd("NoNeckPain"), desc = "No Neck Pain" },
            },
            {
                group = "[Buffers]",
                { "<Leader>Q",  cmd("qa!"),                    desc = "Force Quit" },
                { "<Leader>D",  function() vim.cmd("%bd") end, desc = "Delete ALL Buffers" },
                { "<Leader>bd", cmd("bp | sp | bn | bd"),      desc = "Delete Buffer" },
                { "<Leader>bq", cmd("bd!"),                    desc = "Force delete buffer" },
                { "<Leader>B",  cmd("bp | sp | bn | bd"),      desc = "Delete Buffer" },
            },
            {
                group = "[Explore]",
                -- see lua/plugins/navigation.lua
            },
            {
                group = "[Git]",
                { "<Leader>gg",    cmd("Gitsigns stage_buffer"), desc = "Stage buffer" },
                { "<Leader>gh",    cmd("Gitsigns preview_hunk"), desc = "Preview hunk" },
                { "<Leader>gB",    cmd("Gitsigns blame"),        desc = "Blame sidebar" },
                { "<Leader>gq",    cmd("Gitsigns setqflist"),    desc = "View Hunks" },
                { "<Leader>gr",    cmd("Gitsigns reset_hunk"),   desc = "Reset Hunk" },
                { "<Leader>g<CR>", cmd("Gitsigns stage_hunk"),   desc = "Stage Hunk" },
                { "<Leader>g!",    cmd("Gitsigns reset_buffer"), desc = "Reset buffer to revision" },
            },
            {
                group = "[Search] Snacks Picker",
            },
            {
                group = "[Harpoon]",
                { "<Leader>h", function() require("harpoon.mark").add_file() end,        desc = "Harpoon File" },
                { "<Leader>H", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon List" },
            },
            {
                group = "[LSP]",
                icon = "LSP",
                { "K",          function() vim.lsp.buf.hover() end,                 desc = "Hover" },
                { "gi",         function() vim.lsp.buf.implementation() end,        desc = "Implementation" },
                { "gs",         function() vim.lsp.buf.signature_help() end,        desc = "Signature Help" },
                { "<F2>",       function() vim.lsp.buf.rename() end,                desc = "Rename" },
                { "gr",         function() vim.lsp.buf.references() end,            desc = "References" },
                { "<F3>",       function() require("fastaction").code_action() end, desc = "Code Action" },
                { "gh",         function() vim.diagnostic.open_float() end,         desc = "Diagnostic Float" },
                { "<Leader>qd", function() vim.diagnostic.setloclist() end,         desc = "Set Loclist" },
            },
            {
                group = "[Hacks]",
                { "<Leader>p", '"0p',                                    desc = "Paste from register 0" },
                { "<Leader>P", '"0P',                                    desc = "Paste from register 0" },
                { "<Leader>,", '@@',                                     desc = "Replay macro" },
                -- { "-",         require("user.navigation").lastwin,       desc = "Last Window" },
                -- { "+",         require("user.navigation").lastbuf,       desc = "Last Buffer" },
                { "0",         require("user.navigation").zero_or_first, desc = "Zero or First" },
            },
        },
    },
}
