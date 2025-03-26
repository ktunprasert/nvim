local keymap_opts = require("lib.utils")

return {
    -- ██╗     ███████╗██████╗     ██████╗███╗   ███╗██████╗
    -- ██║     ██╔════╝██╔══██╗   ██╔════╝████╗ ████║██╔══██╗
    -- ██║     ███████╗██████╔╝   ██║     ██╔████╔██║██████╔╝
    -- ██║     ╚════██║██╔═══╝    ██║     ██║╚██╔╝██║██╔═══╝
    -- ███████╗███████║██║███████╗╚██████╗██║ ╚═╝ ██║██║
    -- ╚══════╝╚══════╝╚═╝╚══════╝ ╚═════╝╚═╝     ╚═╝╚═╝     ~ LSP and Autocompletion
    -- CMP dependencies
    -- TODO: Check all things regarding colorful-menu
    { "xzbdmw/colorful-menu.nvim",        config = true, },
    { "giuxtaposition/blink-cmp-copilot", after = { "copilot.lua" } },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets', 'Kaiser-Yang/blink-cmp-avante' },
        version = '1.*',
        config = function()
            local blink_opts = require("user.blinkcmp")
            require("blink.cmp").setup(blink_opts)
        end,
        opts_extend = { "sources.default" }
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            provider = "copilot",
            copilot = {
                endpoint = "https://api.githubcopilot.com",
                -- endpoint = "https://api.individual.githubcopilot.com",
                -- model = "gpt-4o-2024-08-06",
                -- available models
                -- "gpt-3.5-turbo" OK
                -- "gpt-3.5-turbo-0613" OK
                -- "gpt-4o-mini" OK
                -- "gpt-4o-mini-2024-07-18" OK
                -- "gpt-4" OK
                -- "gpt-4-0613" OK
                -- "gpt-4o" OK
                -- "gpt-4o-2024-05-13" OK
                -- "gpt-4-o-preview" OK
                -- "gpt-4o-2024-08-06" OK
                -- "gpt-4o-2024-11-20" OK
                -- "claude-3.5-sonnet" OK
                -- "claude-3.7-sonnet" OK
                -- "claude-3.7-sonnet-thought" OK
                -- "gemini-2.0-flash-001" OK
                --
                -- Untested
                -- "text-embedding-ada-002"
                -- "text-embedding-3-small"
                -- "text-embedding-3-small-inference"
                --
                -- Not OK
                -- The following are found in the API for the Immersive chat mode in GitHub copilot
                -- "o1" NOT OK
                -- "o1-2024-12-17" NOT OK
                -- "o3-mini" NOT OK
                -- "o3-mini-2025-01-31" NOT OK
                -- "o3-mini-paygo" NOT OK
                -- model = "claude-3.7-sonnet-thought",
                model = "claude-3.7-sonnet",
            },
            file_selector = {
                provider = "fzf",
                provider_opts = {},
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            -- "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua",              -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
    -- DAP Debugger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "nvim-neotest/nvim-nio",
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
            {
                "rcarriga/nvim-dap-ui",
                keys = {
                    { "<F7>", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                    { "<F8>", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                },
                lazy = false,
                opts = {},
                config = function(_, opts)
                    -- setup dap config by VsCode launch.json file
                    -- require("dap.ext.vscode").load_launchjs()
                    local dap = require("dap")
                    local dapui = require("dapui")

                    require("user.dap.elixir")
                    require("user.dap.php")

                    dapui.setup(opts)
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open({})
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close({})
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close({})
                    end
                end
            },
        },
        keys = require("user.dap.keys"),
        config = function()
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        end
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            copilot_model = "gpt-4o-copilot",
        },
    },

    -- Snippets engine
    { "L3MON4D3/LuaSnip",                  lazy = false },
    { "rafamadriz/friendly-snippets",      lazy = false },

    -- LSP
    { "williamboman/mason.nvim",           config = true },
    { "williamboman/mason-lspconfig.nvim", config = true },
    { "neovim/nvim-lspconfig",             lazy = false }, -- enable LSP
    {
        "hinell/lsp-timeout.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
    },

    -- Linter/Formatter
    {
        "nvimtools/none-ls.nvim", -- for formatters and linter
        lazy = false,
        config = function() require("user.lsp.null-ls") end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function() require("user.plugins.treesitter") end,
        lazy = false,
        build = ":TSUpdate",
    },
    {
        "simrat39/symbols-outline.nvim",
        lazy = false,
        opts = {
            auto_close = true,
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    },

    {
        "chrisgrieser/nvim-various-textobjs",
        lazy = false,
        opts = { useDefaultKeymaps = true },
    },

    {
        "echasnovski/mini.ai",
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
        },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
        },
        config = function()
            local ai = require("mini.ai")
            ai.setup({
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
                },
            })
        end,
    },

    {
        "drybalka/tree-climber.nvim",
        keys = {
            { mode = { "n", "o" }, '<Left>',  function() require('tree-climber').goto_prev() end, keymap_opts },
            { mode = { "n", "o" }, '<Right>', function() require('tree-climber').goto_next() end, keymap_opts },
        },
    },

    {
        "ziontee113/syntax-tree-surfer",
        name = "sts",
        config = true,
        branch = "2.1",
        keys = {
            { mode = "n", "vx",        '<cmd>STSSelectMasterNode<cr>',      keymap_opts },
            { mode = "n", "vn",        '<cmd>STSSelectCurrentNode<cr>',     keymap_opts },
            { mode = "x", "<Tab>",     '<cmd>STSSelectNextSiblingNode<cr>', keymap_opts },
            { mode = "x", "<S-Tab>",   '<cmd>STSSelectPrevSiblingNode<cr>', keymap_opts },
            { mode = "x", "<Down>",    '<cmd>STSSelectNextSiblingNode<cr>', keymap_opts },
            { mode = "x", "<Up>",      '<cmd>STSSelectPrevSiblingNode<cr>', keymap_opts },
            { mode = "x", "<Left>",    '<cmd>STSSelectParentNode<cr>',      keymap_opts },
            { mode = "x", "<Right>",   '<cmd>STSSelectChildNode<cr>',       keymap_opts },
            { mode = "x", "<BS>",      '<cmd>STSSelectParentNode<cr>',      keymap_opts },
            { mode = "x", "<CR>",      '<cmd>STSSelectChildNode<cr>',       keymap_opts },
            { mode = "x", "<C-Up>",    '<cmd>STSSwapPrevVisual<cr>',        keymap_opts },
            { mode = "x", "<C-Down>",  '<cmd>STSSwapNextVisual<cr>',        keymap_opts },
            { mode = "x", "<C-Left>",  '<cmd>STSSwapPrevVisual<cr>',        keymap_opts },
            { mode = "x", "<C-Right>", '<cmd>STSSwapNextVisual<cr>',        keymap_opts },
            { mode = "x", "<A-h>",     '<cmd>STSSwapPrevVisual<cr>',        keymap_opts },
            { mode = "x", "<A-l>",     '<cmd>STSSwapNextVisual<cr>',        keymap_opts },
        }
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
    },

}
