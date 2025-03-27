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
            pre_save_cmds = { "Neotree close" },
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
        "mg979/vim-visual-multi",
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
}
