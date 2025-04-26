local ok, whichkey = pcall(require, "which-key")
if not ok then
    return
end


local cmd = require("lib.utils").cmdcr

whichkey.setup {
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
        wo = { winblend = 10 },
    },
    layout = {
        height = { min = 4, max = 25 },  -- min and max height of the columns
        width = { min = 20, max = 100 }, -- min and max width of the columns
        spacing = 3,                     -- spacing between columns
        align = "center",                -- align columns left, center or right
    },
    filter = function() return true end,
    triggers = { { "<auto>", mode = "nxso" }, },
}

local leader = {
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
        {
            "<Leader>W",
            function() return require('window-picker').pick_window() or vim.api.nvim_get_current_win() end,
            desc = "Pick Window",
        },
        { "<A-f>", cmd("ZenMode"),    desc = "Zen Mode" },
        { "<A-g>", cmd("NoNeckPain"), desc = "No Neck Pain" },
        {
            "1<A-f>",
            function()
                require("zen-mode").toggle({
                    window = {
                        width = 100,
                        options = { wrap = true }
                    }
                })
            end,
            desc = "Zen Mode - less width"
        },
    },
    {
        group = "[Buffers]",
        { "<Leader>Q",  cmd("qa"),                     desc = "Quit" },
        { "<Leader>D",  function() vim.cmd("%bd") end, desc = "Delete ALL Buffers" },
        { "<Leader>bd", cmd("bp | sp | bn | bd"),      desc = "Delete Buffer" },
        { "<Leader>bq", cmd("bd!"),                    desc = "Force delete buffer" },
        { "<Leader>B",  cmd("bp | sp | bn | bd"),      desc = "Delete Buffer" },
    },
    {
        group = "[Explore]",
        { "<Leader>f",  cmd("Neotree float reveal"),                 desc = "Reveal current file" },
        { "<Leader>bb", cmd("Neotree buffers focus position=float"), desc = "Buffers" },
        { "<A-e>",      cmd("Neotree toggle float filesystem"),      desc = "Explore" }
    },
    {
        group = "[Git]",
        { "<Leader>gg",    cmd("Gitsigns stage_buffer"),                   desc = "Stage buffer" },
        { "<Leader>gh",    cmd("Gitsigns preview_hunk"),                   desc = "Preview hunk" },
        { "<Leader>gH",    cmd("Telescope git_bcommits"),                  desc = "View Git History for current buffer" },
        { "<Leader>gc",    cmd("Telescope git_commits theme=ivy"),         desc = "View Commits" },
        { "<Leader>gb",    cmd("Telescope git_branches theme=ivy"),        desc = "View Branches" },
        { "<Leader>gB",    cmd("Gitsigns blame"),                          desc = "Blame sidebar" },
        { "<Leader>gq",    cmd("Gitsigns setqflist"),                      desc = "View Hunks" },
        { "<Leader>gs",    cmd("Telescope git_status theme=ivy"),          desc = "View Git Status" },
        { "<Leader>gr",    cmd("Gitsigns reset_hunk"),                     desc = "Reset Hunk" },
        { "<Leader>ge",    cmd("Neotree git_status focus position=float"), desc = "Git Status Neotree" },
        { "<Leader>g<CR>", cmd("Gitsigns stage_hunk"),                     desc = "Stage Hunk" },
        { "<Leader>g!",    cmd("Gitsigns reset_buffer"),                   desc = "Reset buffer to revision" },
    },
    {
        group = "[Search] Telescope",
        { "<Leader>!",   cmd("Telescope resume"),                                    desc = "Resume" },
        { "<Leader>p",   cmd("Telescope projects"),                                  desc = "Projects" },
        { "<Leader>R",   cmd("Telescope oldfiles"),                                  desc = "Recent Files (Global)" },
        { "<Leader>r",   cmd("Telescope oldfiles cwd_only=true"),                    desc = "Recent Files" },
        { "<Leader>sg",  cmd("Telescope git_files"),                                 desc = "Git Files" },
        { "<Leader>sf",  cmd("Telescope find_files"),                                desc = "Find All Files" },
        { "<Leader>st",  function() require("user.telescope.multigrep").setup() end, desc = "Text" },
        { "<Leader>sh",  cmd("Telescope help_tags"),                                 desc = "Find Help" },
        { "<Leader>sb",  cmd("Telescope buffers sort_mru=true"),                     desc = "Buffers" },
        { "<Leader>sk",  cmd("Telescope keymaps"),                                   desc = "Keymaps" },
        { "<Leader>s\"", cmd("Telescope registers"),                                 desc = "Registers" },
        {
            "<Leader>sp",
            function()
                require('telescope.builtin').colorscheme({
                    enable_preview = true,
                    prompt_title = "Colourscheme Preview",
                    layout_strategy = "vertical",
                    layout_config = { height = 0.8 },
                })
            end,
            desc = "Colourscheme Preview"
        },
        { "<Leader>ss", cmd("Telescope session-lens search_session"),                  desc = "Sessions" },
        { "<Leader>so", cmd("Telescope lsp_document_symbols theme=ivy"),               desc = "Document Symbols" },
        { "<Leader>sO", cmd("Telescope lsp_workspace_symbols"),                        desc = "Workspace Symbols" },
        { "<Leader>sr", cmd("Telescope lsp_references"),                               desc = "References" },
        { "<Leader>sc", cmd("Telescope commands"),                                     desc = "Commands" },
        { "<Leader>sd", cmd("Telescope diagnostics bufnr=0 theme=ivy"),                desc = "Diagnostics current buffer" },
        { "<Leader>sD", cmd("Telescope diagnostics"),                                  desc = "Global diagnostics" },
        { "<Leader>sm", cmd("Telescope treesitter theme=ivy symbols=function,method"), desc = "Search methods" },
        { "<Leader>sq", cmd("Telescope quickfixhistory theme=ivy "),                   desc = "Quickfix History" },
        { "<C-p>",      cmd("Telescope find_files"),                                   desc = "Fuzzy find files" },
    },
    {
        group = "[Harpoon]",
        { "<Leader>h", function() require("harpoon.mark").add_file() end,        desc = "Harpoon File" },
        { "<Leader>H", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon List" },
    },
    {
        group = "[LSP]",
        { "gD",        function() vim.lsp.buf.declaration() end,                                        desc = "LSP Declaration" },
        { "gd",        function() vim.lsp.buf.definition() end,                                         desc = "LSP Definition" },
        { "K",         function() vim.lsp.buf.hover() end,                                              desc = "LSP Hover" },
        { "gi",        function() vim.lsp.buf.implementation() end,                                     desc = "LSP Implementation" },
        { "<Leader>k", function() vim.lsp.buf.signature_help() end,                                     desc = "LSP Signature Help" },
        { "gs",        function() vim.lsp.buf.signature_help() end,                                     desc = "LSP Signature Help" },
        { "<F2>",      function() vim.lsp.buf.rename() end,                                             desc = "LSP Rename" },
        { "gr",        function() vim.lsp.buf.references() end,                                         desc = "LSP References" },
        { "<F3>",      function() require("fastaction").code_action() end,                              desc = "LSP Code Action" },
        { "gh",        function() vim.diagnostic.open_float() end,                                      desc = "LSP Diagnostic Float" },
        { "<Leader>q", function() vim.diagnostic.setloclist() end,                                      desc = "LSP Set Loclist" },
        { "gl",        function() vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" }) end, desc = "LSP Line Diagnostics" },
    },
    {
        group = "[Hacks]",
        -- { ";", ":", mode = "vn", desc = "Command Mode" },
    }
}

whichkey.add(leader)
