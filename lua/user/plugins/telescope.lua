local telescope = require 'telescope'
local actions = require 'telescope.actions'
local keymap = require 'lib.utils'.keymap

telescope.setup {
    defaults = {
        path_display = { truncate = 1, shorten = 5 },
        mappings = {
            i = {
                ['<Esc>'] = actions.close,
                ['<C-c>'] = actions.close,

                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,

                ['<C-Down>'] = actions.cycle_history_next,
                ['<C-Up>'] = actions.cycle_history_prev,

                ['<CR>'] = actions.select_default + actions.center,
            },
            n = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            },
        },
    },
    initial_mode = "insert",
    file_ignore_patterns = { '.git/', 'node_modules/', 'vendor/', '*.exe' },
    pickers = {
        find_files = {
            hidden = true,
        },
        oldfiles = {
            prompt_title = 'History',
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        },
    },
}

require('telescope').load_extension('fzf')

-- keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
-- keymap('n', '<leader>sF', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]]) -- luacheck: no max line length
-- -- keymap('n', '<leader>r', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
-- keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
-- keymap('n', '<leader>sr', [[<cmd>lua require('telescope').extensions.live_grep_raw.live_grep_raw()<CR>]])
-- keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
-- keymap('n', '<leader>sk', ':Telescope keymaps<CR>')
