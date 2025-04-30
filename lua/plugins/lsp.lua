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
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        dependencies = {
            'rafamadriz/friendly-snippets',
            'Kaiser-Yang/blink-cmp-avante',
            'ribru17/blink-cmp-spell',
            "giuxtaposition/blink-cmp-copilot",
            { "xzbdmw/colorful-menu.nvim", config = true, },
        },
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
            windows = {
                wrap = true, -- similar to vim.o.wrap
                width = 30,  -- default % based on available width
                edit = { start_insert = false, },
                ask = {
                    floating = false,     -- Open the 'AvanteAsk' prompt in a floating window
                    start_insert = false, -- Start insert mode when opening the ask window
                },
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
        dependencies = {
            { "nvim-neotest/nvim-nio", },
            { "theHamsta/nvim-dap-virtual-text", opts = {}, },
            {
                "rcarriga/nvim-dap-ui",
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
    { "neovim/nvim-lspconfig",  lazy = true, },
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
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "lua", "json",
                "javascript", "python", "dockerfile", "bash",
                "php", "phpdoc",
                "go", "gomod",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["gab"] = "@block.outer",
                        ["gib"] = "@block.inner",
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = false,
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]f"] = "@function.outer",
                        ["]b"] = "@block.outer",
                        ["]t"] = "@conditional.outer",
                        ["]?"] = "@comment.outer",
                        ["]l"] = "@variable",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]F"] = "@function.outer",
                        ["]B"] = "@block.outer",
                        ["]T"] = "@conditional.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[f"] = "@function.outer",
                        ["[t"] = "@conditional.outer",
                        ["[b"] = "@block.outer",
                        ["[?"] = "@comment.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[F"] = "@function.outer",
                        ["[B"] = "@block.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            }
        },
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
        dependencies = "nvim-treesitter",
    },

    {
        "chrisgrieser/nvim-various-textobjs",
        event = "VeryLazy",
        opts = { keymaps = { useDefaults = false } },
        -- config = function() require("user.plugins.various") end,
        init = function()
            local various = require("various-textobjs")
            local keymap = require("lib.utils").keymap

            local inoutMaps = {
                subword = "S",
                number = "n",
                lineCharacterwise = "_",
                greedyOuterIndentation = "g",
                anyQuote = "q",
                value = "v",
                key = "k",
            }

            for fn, map in pairs(inoutMaps) do
                keymap({ "o", "x" }, "a" .. map, function() various[fn]("outer") end, nil, "[TOBJ] outer " .. fn)
                keymap({ "o", "x" }, "i" .. map, function() various[fn]("inner") end, nil, "[TOBJ] inner " .. fn)
            end

            local oneMaps = {
                nearEoL = "n",
                visibleInWindow = "gw",
                toNextQuotationMark = '"',
                restOfIndentation = "R",
                column = "|",
                entireBuffer = "gG",
                url = "L",
            }

            for fn, map in pairs(oneMaps) do
                keymap({ "o", "x" }, map, function() various[fn]() end, nil, "[TOBJ] " .. fn)
            end

            local ftMaps = {
                { map = { mdLink = "l" },               fts = { "markdown" } },
                { map = { mdEmphasis = "e" },           fts = { "markdown" } },
                { map = { mdFencedCodeBlock = "C" },    fts = { "markdown" } },
                { map = { doubleSquareBrackets = "D" }, fts = { "lua", "norg", "sh", "fish", "zsh", "bash", "markdown" } },
                { map = { cssSelector = "c" },          fts = { "css", "scss" } },
                { map = { cssColor = "#" },             fts = { "css", "scss" } },
                { map = { shellPipe = "P" },            fts = { "sh", "bash", "zsh", "fish" } },
                { map = { htmlAttribute = "x" },        fts = { "html", "css", "scss", "xml", "vue" } },
            }

            local group = vim.api.nvim_create_augroup("VariousTextobjs", { clear = true })
            for _, textobj in pairs(ftMaps) do
                vim.api.nvim_create_autocmd("FileType", {
                    group = group,
                    pattern = textobj.fts,
                    callback = function()
                        for objName, map in pairs(textobj.map) do
                            local name = " " .. objName .. " textobj"
                            keymap(
                                { "o", "x" },
                                "a" .. map,
                                function() various[objName]("outer") end, { buffer = true },
                                "[TOBJ] outer " .. name)

                            keymap(
                                { "o", "x" },
                                "i" .. map,
                                function() various[objName]("inner") end,
                                { buffer = true },
                                "[TOBJ] inner " .. name)
                        end
                    end,
                })
            end
        end,
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
