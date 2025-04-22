return {
    -- ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗
    -- ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝
    -- ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║
    --  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝   ~ Utility
    {
        "kylechui/nvim-surround",
        opts = { aliases = { ["<"] = "t", }, }
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function() require("user.plugins.gitsigns") end
    },
    {
        "numToStr/Comment.nvim",
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
        lazy = false,
        opts = {
            log_level = 'info',
            pre_save_cmds = { "Neotree close", "helpclose" },
            -- auto_session_enable_last_session = true,
        }
    },
    {
        'rmagatti/session-lens',
        dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        opts = {
            path_display = { "shorten" },
            previewer = false,
            theme_conf = {
                prompt_title = "Sessions",
            },
        }
    },
    {
        "ahmedkhalf/project.nvim",
        config = function() require("user.plugins.project") end
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("user.plugins.autopairs") end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function() require("user.plugins.neotree") end,
        lazy = false,
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
            },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = true,
        keys = {
            { mode = "n", "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "Search TODO comments" },
        }
    },
    {
        "monaqa/dial.nvim",
        lazy = true,
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group {
                default = {
                    augend.constant.alias.bool,
                    augend.constant.alias.de_weekday,
                    augend.constant.alias.de_weekday_full,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%Y/%m/%d'],
                    augend.hexcolor.new({ case = 'upper' }),
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.case.new({
                        types = { 'camelCase', 'snake_case', 'PascalCase' },
                        cyclic = true,
                    }),
                    -- a and b
                    augend.semver.alias.semver,
                }
            }
        end,
        keys = {
            { mode = "n", "<C-a>",  function() require("dial.map").manipulate("increment", "normal") end,  remap = true },
            { mode = "n", "<C-x>",  function() require("dial.map").manipulate("decrement", "normal") end,  remap = true },
            { mode = "n", "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, remap = true },
            { mode = "n", "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, remap = true },
            { mode = "v", "<C-a>",  function() require("dial.map").manipulate("increment", "visual") end,  remap = true },
            { mode = "v", "<C-x>",  function() require("dial.map").manipulate("decrement", "visual") end,  remap = true },
            { mode = "v", "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, remap = true },
            { mode = "v", "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, remap = true },
        },
    },

    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({ "n", "x" }, "<C-up>", function() mc.lineAddCursor(-1) end)
            set({ "n", "x" }, "<C-down>", function() mc.lineAddCursor(1) end)
            set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
            set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

            -- Add or skip adding a new cursor by matching word/selection
            set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end)
            -- set({ "n", "x" }, "<C-l>", function() mc.matchAddCursor(1) end)
            -- set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse)
            set("n", "<c-leftdrag>", mc.handleMouseDrag)
            set("n", "<c-leftrelease>", mc.handleMouseRelease)

            -- Disable and enable cursors.
            set({ "n", "x" }, "<c-q>", mc.toggleCursor)

            -- Mappings defined in a keymap layer only apply when there are
            -- multiple cursors. This lets you have overlapping mappings.
            mc.addKeymapLayer(function(layerSet)
                -- skip cursor
                layerSet({ "n", "x" }, "Q", function() mc.matchSkipCursor(-1) end)
                layerSet({ "n", "x" }, "q", function() mc.matchSkipCursor(1) end)

                -- Select a different cursor as the main one.
                layerSet({ "n", "x" }, "<left>", mc.prevCursor)
                layerSet({ "n", "x" }, "<right>", mc.nextCursor)

                -- Delete the main cursor.
                layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

                -- Enable and clear cursors using escape.
                layerSet("n", "<esc>", function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end)
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
