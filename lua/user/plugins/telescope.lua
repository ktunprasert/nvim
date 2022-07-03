local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

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
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
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
        ['ui-select'] = {
            require("telescope.themes").get_dropdown {
            }
        }
    },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

keymap("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<CR>")
