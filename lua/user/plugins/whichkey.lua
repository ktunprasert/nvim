local ok, whichkey = pcall(require, "which-key")
if not ok then
    return
end


whichkey.setup {
    plugins = {
        marks = true,     -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false,                           -- adds help for operators like d, y, ...
            motions = true,                              -- adds help for motions
            text_objects = true,                         -- help for text objects triggered after entering an operator
            windows = true,                              -- default bindings on <c-w>
            nav = true,                                  -- misc bindings to work with windows
            z = true,                                    -- bindings for folds, spelling and others prefixed with z
            g = true,                                    -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "-",  -- symbol used between a key and it's label
        group = "+",      -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
        border = "none",          -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 0, 0, 0, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },                                           -- min and max height of the columns
        width = { min = 20, max = 50 },                                           -- min and max width of the columns
        spacing = 3,                                                              -- spacing between columns
        align = "center",                                                         -- align columns left, center or right
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    }
}

local opts = {
    mode = "n",
    prefix = "<Leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nmowait = true,
}

local vopts = {
    mode = "v",
    prefix = "<Leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nmowait = true,
}

local vmappings = {
    c = { "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Comment" },
    g = {
        name = "Git",
        ["<Enter>"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
    },
}

local mappings = {
    W = { function()
        local window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(window_id)
    end, "Pick Window" },
    Q = { "<Cmd>qa<CR>", "Quit" },
    l = { "<Cmd>Lazy<CR>", "Lazy" },
    m = { "<Cmd>Mason<CR>", "Mason" },
    ["c"] = { "<Esc><Cmd>lua require('Comment.api').toggle.linewise()<CR>", "Comment" },
    ["f"] = { "<Cmd>Neotree reveal<CR>", "Find Files" },
    F = { "<Cmd>Format<CR>", "Format current file" },
    ["p"] = { "<Cmd>Telescope projects<CR>", "Projects" },
    r = { "<Cmd>Telescope oldfiles<CR>", "Recent Files" },
    D = { "<Cmd>%bd<CR>", "Delete ALL Buffers" },
    G = { name = "LazyGit" },
    g = {
        name = "Git",
        g = { "<Cmd>Gitsigns stage_buffer<CR>", "Git Files" },
        h = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
        H = { "<Cmd>Telescope git_bcommits<cr>", "View Git History for current buffer" },
        c = { "<Cmd>Telescope git_commits<CR>", "View Commits" },
        b = { "<Cmd>Telescope git_branches<CR>", "View Branches" },
        B = { "<Cmd>Gitsigns blame_line<CR>", "Blame current line" },
        s = { "<Cmd>Gitsigns setqflist<CR>", "View Hunks" },
        S = { "<Cmd>Telescope git_status<CR>", "View Git Status" },
        ["<Enter>"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
        ['!'] = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset buffer to revision" },
        r = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
        e = { "<Cmd>Neotree git_status focus position=float<CR>", "Git Status Neotree" },
    },
    s = {
        name = "Search [Telescope]",
        g = { "<Cmd>Telescope git_files<CR>", "Git Files" },
        f = { "<Cmd>Telescope find_files<CR>", "Find All Files" },
        t = { "<Cmd>Telescope live_grep<cr>", "Text" },
        h = { "<Cmd>Telescope help_tags<cr>", "Find Help" },
        b = { "<Cmd>Telescope buffers<CR>", "Buffers" },
        k = { "<Cmd>Telescope keymaps<CR>", "Keymaps" },
        ['"'] = { "<Cmd>Telescope registers<CR>", "Registers" },
        p = { [[<Cmd>lua require'telescope.builtin'.colorscheme({enable_preview = true})<CR>]], "Colourscheme Preview" },
        s = { "<Cmd>Telescope session-lens search_session<CR>", "Sessions" },
        o = { "<Cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        O = { "<Cmd>Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" },
        r = { "<Cmd>Telescope lsp_references<CR>", "References" },
        c = { "<Cmd>Telescope commands<CR>", "Commands" },
        d = { "<Cmd>Telescope diagnostics bufnr=0<CR>", "Diagnostics current buffer" },
        D = { "<Cmd>Telescope diagnostics<CR>", "Global diagnostics" },
    },
    ["/"] = { "<Cmd>HopPattern<CR>", "Hop by Pattern" },
    b = {
        q = { "<Cmd>bd!<CR>", "Force delete buffer" },
        d = { "<Cmd>bp | sp | bn | bd<CR>", "Delete Buffer" },
        b = { "<Cmd>Neotree buffers focus position=float<CR>", "Buffers Neotree" },
    },
    B = { "<Cmd>bp | sp | bn | bd<CR>", "Delete Buffer" },
    h = { function() require("harpoon.mark").add_file() end, "Harpoon File" },
    H = { function() require("harpoon.ui").toggle_quick_menu() end, "Harpoon List" },
}

whichkey.register(mappings, opts)
whichkey.register(vmappings, vopts)
