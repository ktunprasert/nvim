local keymap_opts = require("lib.utils")
local cmd = require("lib.utils").cmdcr

return {
    -- ██╗     ███████╗██████╗     ██████╗███╗   ███╗██████╗
    -- ██║     ██╔════╝██╔══██╗   ██╔════╝████╗ ████║██╔══██╗
    -- ██║     ███████╗██████╔╝   ██║     ██╔████╔██║██████╔╝
    -- ██║     ╚════██║██╔═══╝    ██║     ██║╚██╔╝██║██╔═══╝
    -- ███████╗███████║██║███████╗╚██████╗██║ ╚═╝ ██║██║
    -- ╚══════╝╚══════╝╚═╝╚══════╝ ╚═════╝╚═╝     ╚═╝╚═╝     ~ LSP and Autocompletion
    -- CMP dependencies
    { "xzbdmw/colorful-menu.nvim", config = true, },
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        dependencies = { 'rafamadriz/friendly-snippets', 'Kaiser-Yang/blink-cmp-avante', 'ribru17/blink-cmp-spell', "giuxtaposition/blink-cmp-copilot" },
        version = '*',
        config = function()
            require("user.blinkcmp")
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
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                enabled = false,
                opts = {
                    file_types = { "markdown", "Avante" },
                    debounce = 2000,
                },
                ft = { "markdown", "Avante" },
                overrides = {
                    buftype = {
                        nofile = {
                            code = { left_pad = 0, right_pad = 0 },
                        },
                    },
                },
            },
        },
    },
    -- DAP Debugger
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-neotest/nvim-nio",
                event = "VeryLazy",
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                event = "VeryLazy",
                opts = {},
            },
            {
                "rcarriga/nvim-dap-ui",
                event = "VeryLazy",
                keys = {
                    { "<F7>", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                    { "<F8>", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                },
                opts = {},
                config = function(_, opts)
                    -- setup dap config by VsCode launch.json file
                    -- require("dap.ext.vscode").load_launchjs()
                    local dap = require("dap")
                    local dapui = require("dapui")

                    require("user.dap.elixir")
                    require("user.dap.php")
                    require("user.dap.go")

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
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            copilot_model = "gpt-4o-copilot",
        },
    },

    -- LSP
    { "neovim/nvim-lspconfig",     lazy = true, },
    {
        "williamboman/mason.nvim",
        config = true,
        event = "VeryLazy",
    },

    -- Linter/Formatter
    { "nvimtools/none-ls.nvim", event = "VeryLazy", },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function() require("user.plugins.treesitter") end,
        -- lazy = false,
        event = { "BufReadPre" },
        build = ":TSUpdate",
    },
    {
        "hedyhli/outline.nvim",
        event = "VeryLazy",
        -- lazy = false,
        keys = {
            { "<leader>o", cmd("OutlineFocus"), desc = "Outline" },
        },
        opts = {
            keymaps = {
                down_and_jump = '<Down>',
                up_and_jump = '<Up>',
            },
            outline_window = {
                focus_on_open = false,
            }
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        after = "nvim-treesitter",
    },

    {
        "chrisgrieser/nvim-various-textobjs",
        event = "VeryLazy",
        opts = { keymaps = { useDefaults = false } },
        config = function() require("user.lazy.various") end,
    },

    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
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
        event = "VeryLazy",
        keys = {
            { mode = { "n", "o" }, '<Left>',  function() require('tree-climber').goto_prev() end, keymap_opts },
            { mode = { "n", "o" }, '<Right>', function() require('tree-climber').goto_next() end, keymap_opts },
        },
    },

    {
        "ziontee113/syntax-tree-surfer",
        event = "VeryLazy",
        name = "sts",
        config = true,
        branch = "2.1",
        keys = {
            { mode = "n", "vx",      cmd("STSSelectMasterNode"),      keymap_opts },
            { mode = "n", "vn",      cmd("STSSelectCurrentNode"),     keymap_opts },
            { mode = "x", "<Tab>",   cmd("STSSelectNextSiblingNode"), keymap_opts },
            { mode = "x", "<S-Tab>", cmd("STSSelectPrevSiblingNode"), keymap_opts },
            { mode = "x", "<Right>", cmd("STSSelectNextSiblingNode"), keymap_opts },
            { mode = "x", "<Left>",  cmd("STSSelectPrevSiblingNode"), keymap_opts },
            { mode = "x", "<Up>",    cmd("STSSelectParentNode"),      keymap_opts },
            { mode = "x", "<Down>",  cmd("STSSelectChildNode"),       keymap_opts },
            { mode = "x", "<BS>",    cmd("STSSelectParentNode"),      keymap_opts },
            { mode = "x", "<CR>",    cmd("STSSelectChildNode"),       keymap_opts },
            { mode = "x", "<A-h>",   cmd("STSSwapPrevVisual"),        keymap_opts },
            { mode = "x", "<A-l>",   cmd("STSSwapNextVisual"),        keymap_opts },
            -- { mode = "x", "<C-Up>",    cmd("STSSwapPrevVisual"),        keymap_opts },
            -- { mode = "x", "<C-Down>",  cmd("STSSwapNextVisual"),        keymap_opts },
            -- { mode = "x", "<C-Left>",  cmd("STSSwapPrevVisual"),        keymap_opts },
            -- { mode = "x", "<C-Right>", cmd("STSSwapNextVisual"),        keymap_opts },
        }
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
    },
    {
        "chrisgrieser/nvim-scissors",
        event = "VeryLazy",
        opts = {
            snippetDir = vim.fn.stdpath("config") .. "/snippets",
        },
    },
    {
        'Chaitanyabsprip/fastaction.nvim',
        opts = {
            dismiss_keys = { "j", "k", "<c-c>", "q", "<Esc>" },
            -- override_function = function()end, -- TODO: implement a "number-first" key quick jump
            priority = {
                go = {
                    { pattern = "organize import", key = "o", order = 1 },
                },
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        priority = 1000,
        opts = {
            preset = "minimal",
            options = {
                show_source = { enabled = true },
                throttle = 150,
                multilines = { enabled = true },
            },

        },
    },
    {
        'ckolkey/ts-node-action',
        opts = {},
        lazy = true,
    },
    {
        'windwp/nvim-ts-autotag',
        ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "html", "markdown", "heex" },
        opts = {},
    },
}
