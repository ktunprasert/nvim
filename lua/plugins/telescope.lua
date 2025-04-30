return {
    -- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
    -- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
    --    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
    --    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
    --    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
    --    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝ ~ Telescope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-telescope/telescope-live-grep-raw.nvim' },
            { "nvim-telescope/telescope-hop.nvim", },
            { "nvim-telescope/telescope-ui-select.nvim", },
        },
        config = function()
            local actions = require('telescope.actions')
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    preview = {
                        filesize_limit = 0.5,
                        treesitter = { disable = { "javascript", "json" } },
                    },
                    -- border = false,
                    -- wrap_results = true,
                    -- path_display = { truncate = 1, shorten = 5 },
                    path_display = { "filename_first", truncate = 1 },
                    file_ignore_patterns = { '.git/', 'node_modules/', 'vendor/', '*.exe', "*.lock", "*.sum", "*-lock.json" },
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
                        "--trim",
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

                            ["<C-Space>"] = function(prompt_bufno)
                                telescope.extensions.hop._hop(prompt_bufno, { callback = actions.select_default })
                            end,

                            ["<C-u>"] = false,
                            ["<A-;>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        },
                        n = {
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['q'] = actions.toggle_selection + actions.move_selection_next,
                            ['Q'] = actions.toggle_selection + actions.move_selection_previous,
                        },
                    },
                    prompt_prefix = "  ",
                    selection_caret = "> ",
                    entry_prefix = "  ",
                    selection_strategy = "reset",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            preview_width = 0.6,
                            width = 175,
                            height = 45,
                            -- width = { padding = 0 },
                            -- height = { padding = 0 },
                            prompt_position = "top",
                            -- mirror = true,
                        },
                        vertical = {
                            mirror = false,
                        },
                        -- width = .80,
                        -- height = 500,
                        -- preview_cutoff = 120,
                    },
                    sorting_strategy = "ascending",
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    winblend = 0,
                    border = {},
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
                        find_command = { "fd", "-t", "f", "--strip-cwd-prefix" },
                    },
                    oldfiles = {
                        prompt_title = 'History',
                    },
                    live_grep = {
                        only_sort_text = true,
                    },
                    buffers = {
                        theme = "ivy",
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer,
                            }
                        }
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require("telescope.themes").get_dropdown {
                        }
                    },

                    hop = {
                        -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
                        keys = {
                            "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                            "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
                            "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                            "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
                            "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", },
                        -- Highlight groups to link to signs and lines; the below configuration refers to demo
                        -- sign_hl typically only defines foreground to possibly be combined with line_hl
                        sign_hl = { "WarningMsg", "Title" },
                        -- optional, typically a table of two highlight groups that are alternated between
                        line_hl = { "CursorLine", "Normal" },
                        -- options specific to `hop_loop`
                        -- true temporarily disables Telescope selection highlighting
                        clear_selection_hl = false,
                        -- highlight hopped to entry with telescope selection highlight
                        -- note: mutually exclusive with `clear_selection_hl`
                        trace_entry = true,
                        -- jump to entry where hoop loop was started from
                        reset_selection = true,
                    },
                },
            })

            telescope.load_extension('hop')
            telescope.load_extension('ui-select')
            telescope.load_extension("projects")
        end
    },
}
