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
        event = "VeryLazy",
        opts = { aliases = { ["<"] = "t", }, }
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        -- event = "VeryLazy",
        gt = { "gitcommit", "diff" },
        dependencies = "nvim-lua/plenary.nvim",
        config = function() require("user.plugins.gitsigns") end,
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    ---@diagnostic disable-next-line: undefined-field
                    vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" },
                        {
                            on_exit = function(_, return_code)
                                if return_code == 0 then
                                    pcall(vim.api.nvim_del_augroup_by_name, "GitSignsLazyLoad")
                                    vim.schedule(function()
                                        require("lazy").load { plugins = { "gitsigns.nvim" } }
                                    end)
                                end
                            end
                        }
                    )
                end,
            })
        end,
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
            { "gc", desc = "Comment", },
            { "gc", desc = "Comment", mode = { "v" } }
        },
        opts = {
            ignore = "^$",
            mappings = {
                basic = true,
                extra = false,
            },
        }
    },
    {
        "akinsho/toggleterm.nvim",
        lazy = false,
        version = '*',
        config = function() require("user.plugins.toggleterm") end
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
        config = function() require("user.plugins.project") end
    },
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function() require("user.plugins.autopairs") end
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
        config = function() require("user.plugins.neotree") end,
        event = "VeryLazy",
    },

    {
        "s1n7ax/nvim-window-picker",
        name = 'window-picker',
        version = '2.*',
        event = 'VeryLazy',
        opts = {
            selection_chars = "ABCDEFGHIJK",
            include_current = false,
            se_winbar = "always",
            filter_rules = {
                autoselect_one = true,
                include_current_win = true,
                bo = {
                    filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },
                    buftype = { 'terminal' },
                },
            },
        },
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
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            ---@diagnostic disable-next-line: undefined-global
            { "<leader>.",  function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
            { "<leader>'",  function() Snacks.scratch({ ft = "markdown" }) end,   desc = "Toggle Scrach Todo" },
            { "<leader>S",  function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
            { "<A-f>",      function() Snacks.zen({ win = { width = 0.8 } }) end, desc = "Zen Mode" },
            { "1<A-f>",     function() Snacks.zen({ win = { width = 100 } }) end, desc = "Zen Mode (less width)" },
            { "<leader>sH", function() Snacks.notifier.show_history() end,        desc = "Show notifier history" },
        },
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            quickfile = { enabled = true },
            scratch = {
                win = {
                    style = "scratch",
                    noautocmd = true,
                    minimal = true,
                },
                win_by_ft = {
                    lua = {
                        keys = {
                            ["source"] = {
                                "<cr>",
                                function(self)
                                    local name = "scratch." ..
                                        vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                                    Snacks.debug.run({ buf = self.buf, name = name })
                                end,
                                desc = "Source buffer",
                                mode = { "n", "x" },
                            },
                        },
                    },
                    go = {
                        keys = {
                            ["source"] = {
                                "<cr>",
                                function(self)
                                    -- TODO: ensure we set this up properly
                                    local name = "scratch." ..
                                        vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                                    Snacks.debug.run({ buf = self.buf, name = name })
                                    vim.cmd("$r!echo -n '//' && go run %")
                                end,
                                desc = "Print at bottom",
                                mode = { "n", "x" },
                            },
                        },
                    },
                },
            },
            zen = {
                toggles = {
                    dim = false,
                },
                minimal = true,
            },
            statuscolumn = {},
            -- TODO: also include search count in notifier keepalive somehow
            notifier = {
                style = "minimal",
                top_down = false,
                margin = { bottom = 1, right = 0 },
                filter = function()
                    return true
                end,
            },
            indent = {
                chunk = {
                    enabled = true,
                    only_current = true,
                },
                animate = {
                    enabled = false,
                },
                scope = {
                    underline = true,
                    only_current = true,
                },
            },
        },
        config = function(cfg)
            require("snacks").setup(cfg.opts)
            require("user.plugins.snacks-autocmd")
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        -- lazy = false,
        config = true,
        keys = {
            { mode = "n", "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "Search TODO comments" },
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

    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        event = "VeryLazy",
        config = function() require("user.plugins.multicursor") end,
    },
}
