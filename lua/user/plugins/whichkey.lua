local ok, whichkey = pcall(require, "which-key")
if not ok then
    return
end


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
            "<Cmd>Format<CR>",
            desc = "Format current file",
        },
    },
    {
        group = "[Dependencies]",
        { "<Leader>l", "<Cmd>Lazy<CR>",  desc = "Lazy",  icon = "LZ" },
        { "<Leader>m", "<Cmd>Mason<CR>", desc = "Mason", icon = "MS" },
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
        { "<A-f>", "<cmd>ZenMode<CR>",    desc = "Zen Mode" },
        { "<A-g>", "<cmd>NoNeckPain<CR>", desc = "No Neck Pain" },
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
        { "<Leader>Q",  "<Cmd>qa<CR>",                desc = "Quit" },
        { "<Leader>D",  "<Cmd>%bd<CR>",               desc = "Delete ALL Buffers" },
        { "<Leader>bd", "<Cmd>bp | sp | bn | bd<CR>", desc = "Delete Buffer" },
        { "<Leader>bq", "<Cmd>bd!<CR>",               desc = "Force delete buffer" },
        { "<Leader>B",  "<Cmd>bp | sp | bn | bd<CR>", desc = "Delete Buffer" },
    },
    {
        group = "[Explore]",
        { "<Leader>f",  "<Cmd>Neotree float reveal<CR>",                 desc = "Reveal current file" },
        { "<Leader>bb", "<Cmd>Neotree buffers focus position=float<CR>", desc = "Buffers" },
        { "<A-e>",      "<Cmd>Neotree toggle float filesystem<CR>",      desc = "Explore" }
    },
    {
        group = "[Git]",
        { "<Leader>gg",    "<Cmd>Gitsigns stage_buffer<CR>",                   desc = "Stage buffer" },
        { "<Leader>gh",    "<Cmd>Gitsigns preview_hunk<CR>",                   desc = "Preview hunk" },
        { "<Leader>gH",    "<Cmd>Telescope git_bcommits<cr>",                  desc = "View Git History for current buffer" },
        { "<Leader>gc",    "<Cmd>Telescope git_commits theme=ivy<CR>",         desc = "View Commits" },
        { "<Leader>gb",    "<Cmd>Telescope git_branches theme=ivy<CR>",        desc = "View Branches" },
        { "<Leader>gB",    "<Cmd>Gitsigns blame<CR>",                          desc = "Blame sidebar" },
        { "<Leader>gq",    "<Cmd>Gitsigns setqflist<CR>",                      desc = "View Hunks" },
        { "<Leader>gs",    "<Cmd>Telescope git_status theme=ivy<CR>",          desc = "View Git Status" },
        { "<Leader>gr",    "<Cmd>Gitsigns reset_hunk<CR>",                     desc = "Reset Hunk" },
        { "<Leader>ge",    "<Cmd>Neotree git_status focus position=float<CR>", desc = "Git Status Neotree" },
        { "<Leader>g<CR>", "<Cmd>Gitsigns stage_hunk<CR>",                     desc = "Stage Hunk" },
        { "<Leader>g!",    "<Cmd>Gitsigns reset_buffer<CR>",                   desc = "Reset buffer to revision" },
    },
    {
        group = "[Search] Telescope",
        { "<Leader>p",   "<Cmd>Telescope projects<CR>",                              desc = "Projects" },
        { "<Leader>R",   "<Cmd>Telescope oldfiles<CR>",                              desc = "Recent Files (Global)" },
        { "<Leader>r",   "<Cmd>Telescope oldfiles cwd_only=true<CR>",                desc = "Recent Files" },
        { "<Leader>sg",  "<Cmd>Telescope git_files<CR>",                             desc = "Git Files" },
        { "<Leader>sf",  "<Cmd>Telescope find_files<CR>",                            desc = "Find All Files" },
        { "<Leader>st",  function() require("user.telescope.multigrep").setup() end, desc = "Text" },
        { "<Leader>sh",  "<Cmd>Telescope help_tags<cr>",                             desc = "Find Help" },
        { "<Leader>sb",  "<Cmd>Telescope buffers sort_mru=true<CR>",                 desc = "Buffers" },
        { "<Leader>sk",  "<Cmd>Telescope keymaps<CR>",                               desc = "Keymaps" },
        { "<Leader>s\"", "<Cmd>Telescope registers<CR>",                             desc = "Registers" },
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
        { "<Leader>ss", "<Cmd>Telescope session-lens search_session<CR>",                  desc = "Sessions" },
        { "<Leader>so", "<Cmd>Telescope lsp_document_symbols theme=ivy<CR>",               desc = "Document Symbols" },
        { "<Leader>sO", "<Cmd>Telescope lsp_workspace_symbols<CR>",                        desc = "Workspace Symbols" },
        { "<Leader>sr", "<Cmd>Telescope lsp_references<CR>",                               desc = "References" },
        { "<Leader>sc", "<Cmd>Telescope commands<CR>",                                     desc = "Commands" },
        { "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0 theme=ivy<CR>",                desc = "Diagnostics current buffer" },
        { "<Leader>sD", "<Cmd>Telescope diagnostics<CR>",                                  desc = "Global diagnostics" },
        { "<Leader>sm", "<Cmd>Telescope treesitter theme=ivy symbols=function,method<CR>", desc = "Search methods" },
        { "<Leader>sq", "<Cmd>Telescope quickfixhistory theme=ivy <CR>",                   desc = "Quickfix History" },
        { "<C-p>",      "<Cmd>Telescope find_files<CR>",                                   desc = "Fuzzy find files" },
    },
    {
        group = "[Search] Hop",
        { "<Leader>/", "<Cmd>HopPattern<CR>", desc = "Hop by Pattern" },
    },
    {
        group = "[Harpoon]",
        { "<Leader>h", function() require("harpoon.mark").add_file() end,        desc = "Harpoon File" },
        { "<Leader>H", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon List" },
    },
    {
        group = "[LSP]",
        { "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>",                                        desc = "LSP Declaration" },
        { "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>",                                         desc = "LSP Definition" },
        { "K",         "<cmd>lua vim.lsp.buf.hover()<CR>",                                              desc = "LSP Hover" },
        { "gi",        "<cmd>lua vim.lsp.buf.implementation()<CR>",                                     desc = "LSP Implementation" },
        { "<Leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>",                                     desc = "LSP Signature Help" },
        { "gs",        "<cmd>lua vim.lsp.buf.signature_help()<CR>",                                     desc = "LSP Signature Help" },
        { "<F2>",      "<cmd>lua vim.lsp.buf.rename()<CR>",                                             desc = "LSP Rename" },
        { "gr",        "<cmd>lua vim.lsp.buf.references()<CR>",                                         desc = "LSP References" },
        { "<F3>",      function() require("fastaction").code_action() end,                              desc = "LSP Code Action" },
        { "gh",        "<cmd>lua vim.diagnostic.open_float()<CR>",                                      desc = "LSP Diagnostic Float" },
        { "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>",                                      desc = "LSP Set Loclist" },
        { "gl",        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', desc = "LSP Line Diagnostics" },
    },
    {
        group = "[Hacks]",
        -- { ";", ":", mode = "vn", desc = "Command Mode" },
    }
}

whichkey.add(leader)
