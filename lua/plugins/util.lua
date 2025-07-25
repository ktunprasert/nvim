---@diagnostic disable: missing-fields
return {
    -- ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗
    -- ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝
    -- ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║
    --  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝   ~ Utility
    {
        "kylechui/nvim-surround",
        keys = {
            { mode = "n",          "ys",     desc = "Add surround" },
            { mode = "n",          "yss",    desc = "Add surround to line" },
            { mode = "n",          "yS",     desc = "Add surround with new line" },
            { mode = "n",          "ySS",    desc = "Add surround to line with new line" },
            { mode = "n",          "ds",     desc = "Delete surround" },
            { mode = "n",          "cs",     desc = "Change surround" },
            { mode = "n",          "cS",     desc = "Change surround with new line" },
            { mode = { "o", "i" }, "<C-g>s", desc = "Add surround in insert mode" },
            { mode = { "o", "i" }, "<C-g>S", desc = "Add surround with new line in insert mode" },
            { mode = { "o", "v" }, "S",      desc = "Add surround in visual mode" },
            { mode = { "o", "v" }, "gS",     desc = "Add surround with new line in visual mode" },
        },
        opts = { aliases = { ["<"] = "t", }, }
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            {
                "<Leader>c",
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
                "<C-c>",
                "<Esc><Cmd>lua require('Comment.api').toggle.linewise()<CR>",
                desc = "Comment",
            },
            {
                "<C-c>",
                "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
                desc = "Comment",
                mode = { "v", "x" }
            },
            { "gc", desc = "Comment", },
            { "gc", desc = "Comment", mode = { "v" } }
        },
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        opts = {
            ignore = "^$",
            mappings = {
                basic = true,
                extra = false,
            },
        },
        config = function(cfg)
            cfg.opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
            require("Comment").setup(cfg.opts)
        end
    },
    {
        'rmagatti/auto-session',
        opts = {
            lazy_support = true,
            log_level = 'info',
            pre_save_cmds = { "Neotree close" },
            session_lens = {
                load_on_setup = false,
            }
        }
    },
    {
        "ahmedkhalf/project.nvim",
        name = "project_nvim",
        opts = {
            ---@usage set to true to disable setting the current-woriking directory
            --- Manual mode doesn't automatically change your root directory, so you have
            --- the option to manually do so using `:ProjectRoot` command.
            manual_mode = false,

            ---@usage Methods of detecting the root directory
            --- Allowed values: **"lsp"** uses the native neovim lsp
            --- **"pattern"** uses vim-rooter like glob pattern matching. Here
            --- order matters: if one is not detected, the other is used as fallback. You
            --- can also delete or rearangne the detection methods.
            detection_methods = { "pattern" },

            ---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
            patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile" },

            ---@ Show hidden files in telescope when searching for files in a project
            show_hidden = false,

            ---@usage When set to false, you will get a message when project.nvim changes your directory.
            -- When set to false, you will get a message when project.nvim changes your directory.
            silent_chdir = false,

            ---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
            ignore_lsp = {},

            ---@type string
            ---@usage path to store the project history for use in telescope
            datapath = vim.fn.stdpath('data'),

            exclude_dirs = {
                vim.fn.stdpath('data'),
                "~/go/pkg/",
                "node_modules",
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = false,
        branch = "v3.x",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function() require("user.graveyard.neotree") end,
        event = "VeryLazy",
    },
    {
        'stevearc/quicker.nvim',
        event = "FileType qf",
        keys = {
            { mode = "n", "<leader>qq", function() require("quicker").toggle() end },
            { mode = "n", "<leader>ql", function() require("quicker").toggle({ loclist = true }) end },
        },
        opts = {
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
                { "+", function() require("quicker").expand({ before = 0, after = 1, add_to_existing = true }) end },
                { "-", function() require("quicker").expand({ before = 1, after = 0, add_to_existing = true }) end },
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "TodoLocList",
        config = true,
        keys = {
            { mode = "n", "<leader>sT", "<cmd>TodoLocList<cr>", desc = "Search TODO comments" },
        }
    },
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")

            require("dial.config").augends:register_group {
                default = {
                    augend.constant.alias.bool,
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                },
                visual = {
                    augend.constant.alias.bool,
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                    augend.hexcolor.new({ case = 'upper' }),
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%Y/%m/%d'],
                    augend.constant.alias.de_weekday,
                    augend.constant.alias.de_weekday_full,
                    augend.case.new({
                        types = { 'camelCase', 'snake_case', 'PascalCase' },
                        cyclic = true,
                    }),
                    augend.semver.alias.semver,
                },
            }

            require("dial.config").augends:on_filetype {
                racket = {
                    augend.constant.new {
                        elements = { "lambda", "λ" },
                        word = true,
                        cyclic = true,
                    },
                    augend.constant.new {
                        elements = { "#t", "#f" },
                        word = true,
                        cyclic = true,
                    },
                    augend.constant.new {
                        elements = { "=", "eq?", "eqv?", "equal?" },
                        word = true,
                        cyclic = true,
                    },
                },
            }
        end,
        keys = {
            { mode = "n", "<C-a>",  function() require("dial.map").manipulate("increment", "normal") end,            remap = true },
            { mode = "n", "<C-x>",  function() require("dial.map").manipulate("decrement", "normal") end,            remap = true },
            { mode = "n", "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end,           remap = true },
            { mode = "n", "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end,           remap = true },
            { mode = "v", "<C-a>",  function() require("dial.map").manipulate("increment", "visual", "visual") end,  remap = true },
            { mode = "v", "<C-x>",  function() require("dial.map").manipulate("decrement", "visual", "visual") end,  remap = true },
            { mode = "v", "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual", "visual") end, remap = true },
            { mode = "v", "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual", "visual") end, remap = true },
        },
    },
}
