local telescope = require 'telescope'
local actions = require 'telescope.actions'
local keymap = require 'lib.utils'.keymap

telescope.setup {
    defaults = {
        path_display = { truncate = 1, shorten = 5 },
        initial_mode = "insert",
        file_ignore_patterns = { '.git/', 'node_modules/', 'vendor/', '*.exe' },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
        },
        mappings = {
            i = {
                ['<C-c>'] = actions.close,

                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,

                ['<C-Down>'] = actions.cycle_history_next,
                ['<C-Up>'] = actions.cycle_history_prev,

                ['<CR>'] = actions.select_default + actions.center,

                ['<A-l>'] = actions.select_vertical + actions.center,
                ['<A-j>'] = actions.select_horizontal + actions.center,
            },
            n = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        oldfiles = {
            prompt_title = 'History',
        },
        live_grep = {
            only_sort_text = true,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            case_mode = 'smart_case',
        },
    },
}

require('telescope').load_extension('fzf')
