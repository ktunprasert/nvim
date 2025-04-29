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
                                    vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
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
        event = "VeryLazy",
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
            { "<leader>.", function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
            { "<leader>S", function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
            { "<A-f>",     function() Snacks.zen({ win = { width = 0.8 } }) end, desc = "Zen Mode" },
            { "1<A-f>",    function() Snacks.zen({ win = { width = 100 } }) end, desc = "Zen Mode (less width)" },
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
        },
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
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            local set = vim.keymap.set

            -- for expressions
            -- e.g. ga3j, gaR
            set({ "n", "x" }, "ga", mc.addCursorOperator, { desc = "[MULTC] Operator" })
            set({ "n", "x" }, "<leader><leader>m", mc.addCursorOperator, { desc = "[MULTC] Operator" })

            -- Split visual selections by regex.
            set("x", "zs", mc.splitCursors, { desc = "[MULTC] Split Regex" })

            -- bring back cursors if you accidentally clear them
            set("n", "gV", mc.restoreCursors, { desc = "[MULTC] Restore Cursors" })

            -- Add or skip cursor above/below the main cursor.
            set({ "n", "x" }, "<C-up>", function() mc.lineAddCursor(-1) end, { desc = "[MULTC] Add Cursor Up" })
            set({ "n", "x" }, "<C-down>", function() mc.lineAddCursor(1) end, { desc = "[MULTC] Add Cursor Down" })
            set({ "n", "x" }, "<leader>k", function() mc.lineSkipCursor(-1) end, { desc = "[MULTC] Skip Up" })
            set({ "n", "x" }, "<leader>j", function() mc.lineSkipCursor(1) end, { desc = "[MULTC] Skip Down" })

            -- Add or skip adding a new cursor by matching word/selection
            set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "[MULTC] Next Match" })

            -- Add a cursor for all matches of cursor word/selection in the document.
            set({ "n", "x" }, "<leader><leader>M", mc.matchAllAddCursors, { desc = "[MULTC] All Matches" })
            set({ "n", "x" }, "<leader>M", mc.matchAllAddCursors, { desc = "[MULTC] All Matches" })

            -- Pressing `<leader>miwap` will create a cursor in every match of the
            -- string captured by `iw` inside range `ap`.
            -- This action is highly customizable, see `:h multicursor-operator`.
            set({ "n", "x" }, "<leader><leader>s", mc.operator, { desc = "[MULTC] Operator in Range" })

            -- Add a cursor to every search result in the buffer.
            set("n", "<leader>/", mc.searchAllAddCursors, { desc = "[MULTC] All Search Matches" })

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse, { desc = "[MULTC] Mouse" })
            set("n", "<c-leftdrag>", mc.handleMouseDrag, { desc = "[MULTC] Drag" })
            set("n", "<c-leftrelease>", mc.handleMouseRelease, { desc = "[MULTC] Drag OK" })

            -- Disable and enable cursors.
            set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "[MULTC] Manual" })

            -- Add or skip adding a new cursor by matching diagnostics.
            set({ "n", "x" },
                "<leader><leader>]d",
                function() mc.diagnosticAddCursor(1) end,
                { desc = "[MULTC] Next Diagnostic" })
            set({ "n", "x" },
                "<leader><leader>[d",
                function() mc.diagnosticAddCursor(-1) end,
                { desc = "[MULTC] Prev Diagnostic" })

            -- Mappings defined in a keymap layer only apply when there are
            -- multiple cursors. This lets you have overlapping mappings.
            mc.addKeymapLayer(function(layerSet)
                -- skip cursor
                layerSet({ "n", "x" }, "Q", function() mc.matchSkipCursor(-1) end, { desc = "[MULTC] Skip Prev" })
                layerSet({ "n", "x" }, "q", function() mc.matchSkipCursor(1) end, { desc = "[MULTC] Skip Next" })

                -- Select a different cursor as the main one.
                layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "[MULTC] Prev" })
                layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "[MULTC] Next" })

                -- Delete the main cursor.
                layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "[MULTC] Delete Cursor" })
                layerSet({ "n", "x" }, "<BS>", mc.deleteCursor, { desc = "[MULTC] Delete Cursor" })

                -- Enter to confirm C-Q selection
                layerSet("n", "<CR>", mc.enableCursors, { desc = "[MULTC] Confirm" })
                -- Enable and clear cursors using escape.
                layerSet("n", "<esc>", mc.clearCursors, { desc = "[MULTC] Clear" })
            end)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { reverse = true })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn" })
            hl(0, "MultiCursorMatchPreview", { link = "Search" })
            hl(0, "MultiCursorDisabledCursor", { reverse = true })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
        end,
    },
}
