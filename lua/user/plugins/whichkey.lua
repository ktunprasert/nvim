local whichkey = require 'which-key'

whichkey.setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
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
    ["c"] = { "<Esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" }, -- todo: add commenting plugin
}

local mappings = {
    ["c"] = { "<Esc><cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
    s = {
        name = "Search [Telescope]",
        f = { ":Telescope git_files<CR>", "Find Files" },
        F = { ":Telescope find_files<CR>", "Find All Files" },
        b = { ":Telescope buffers<CR>", "Buffers" },
        r = { ":Telescope oldfiles<CR>", "Recent Files" },
        k = { ":Telescope keymaps<CR>", "Keymaps" },
        ['"'] = { ":Telescope registers<CR>", "Registers" },
        p = { [[<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>]], "Colourscheme Preview" },
    },
}

whichkey.register(mappings, opts)
whichkey.register(vmappings, vopts)
