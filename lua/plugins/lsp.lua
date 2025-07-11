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
        event = { "InsertEnter", "CmdlineEnter" },
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
    -- DAP Debugger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            'Chaitanyabsprip/fastaction.nvim',
            "nvim-neotest/nvim-nio",
            { "theHamsta/nvim-dap-virtual-text", opts = {}, },
            {
                "rcarriga/nvim-dap-ui",
                opts = {},
                config = function(_, opts)
                    -- setup dap config by VsCode launch.json file
                    -- require("dap.ext.vscode").load_launchjs()
                    local dap = require("dap")
                    local dapui = require("dapui")

                    dap.set_log_level('TRACE')

                    require("user.dap.elixir")
                    require("user.dap.php")
                    require("user.dap.go")
                    require("user.dap.rust")

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
        keys = {
            {
                "<leader>dB",
                function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                desc = "Breakpoint Condition"
            },
            {
                "<leader>db",
                function() require("dap").toggle_breakpoint() end,
                desc = "Toggle Breakpoint"
            },
            {
                "<leader>dc",
                function() require("dap").continue() end,
                desc = "Continue"
            },
            -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
            {
                "<leader>dC",
                function() require("dap").run_to_cursor() end,
                desc = "Run to Cursor"
            },
            {
                "<leader>dg",
                function() require("dap").goto_() end,
                desc = "Go to line (no execute)"
            },
            {
                "<leader>di",
                function() require("dap").step_into() end,
                desc = "Step Into"
            },
            {
                "<leader>dj",
                function() require("dap").down() end,
                desc = "Down"
            },
            {
                "<leader>dk",
                function() require("dap").up() end,
                desc = "Up"
            },
            {
                "<leader>dl",
                function() require("dap").run_last() end,
                desc = "Run Last"
            },
            {
                "<leader>do",
                function() require("dap").step_out() end,
                desc = "Step Out"
            },
            {
                "<leader>dO",
                function() require("dap").step_over() end,
                desc = "Step Over"
            },
            {
                "<leader>dp",
                function() require("dap").pause() end,
                desc = "Pause"
            },
            {
                "<leader>dr",
                function() require("dap").repl.toggle() end,
                desc = "Toggle REPL"
            },
            {
                "<leader>ds",
                function() require("dap").session() end,
                desc = "Session"
            },
            {
                "<leader>dt",
                function() require("dap").terminate() end,
                desc = "Terminate"
            },
            {
                "<leader>dw",
                function() require("dap.ui.widgets").hover() end,
                desc = "Widgets"
            },
            { "<F7>", function() require("dapui").toggle({}) end, desc = "Dap UI" },
            { "<F8>", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
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
    { "neovim/nvim-lspconfig", lazy = true },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonUpdate" },
        opts = {},
    },

    -- Linter/Formatter
    {
        "nvimtools/none-ls.nvim",
        event = "LspAttach",
        config = function()
            local null_ls_status_ok, null_ls = pcall(require, "null-ls")
            if not null_ls_status_ok then
                return
            end

            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            local formatting = null_ls.builtins.formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            local diagnostics = null_ls.builtins.diagnostics

            local h = require("null-ls.helpers")
            local FMT = require("null-ls.methods").internal.FORMATTING

            null_ls.setup({
                debug = true,
                sources = {
                    formatting.prettier.with({ extra_args = {}, filetypes = { "markdown", "md", "mdx", "astro" } }),
                    formatting.black.with({ extra_args = { "--fast" } }),
                    formatting.biome,
                    formatting.ocamlformat,
                    -- formatting.prettypst,
                    diagnostics.golangci_lint,
                    -- null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.code_actions.ts_node_action,
                    h.make_builtin(
                        {
                            name = "racket raco fmt",
                            method = FMT,
                            filetypes = { "rkt", "racket" },
                            generator_opts = {
                                command = "raco",
                                args = { "fmt" },
                                to_stdin = true,
                            },
                            factory = h.formatter_factory,
                        }),
                    h.make_builtin(
                        {
                            name = "roc fmt",
                            method = FMT,
                            filetypes = { "roc" },
                            generator_opts = {
                                command = "roc",
                                args = { "format", "--migrate", "--stdin", "--stdout" },
                                to_stdin = true,
                            },
                            factory = h.formatter_factory,
                        }),
                    -- h.make_builtin(
                    --     {
                    --         name = "v fmt",
                    --         method = FMT,
                    --         filetypes = { "v" },
                    --         generator_opts = {
                    --             command = "v",
                    --             args = { "fmt" },
                    --             to_stdin = true,
                    --         },
                    --         factory = h.formatter_factory,
                    --     }
                    -- ),
                },
            })
        end,
    },

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
                enable = false
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "vx",
                    node_incremental = "<BS>",
                    node_decremental = "<CR>",
                    scope_incremental = "<TAB>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        -- ["af"] = "@function.outer",
                        -- ["if"] = "@function.inner",
                        -- ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        -- ["gab"] = "@block.outer",
                        -- ["gib"] = "@block.inner",
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
        cmd = { "Outline", "OutlineFocus" },
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
        config = function(cfg)
            local various = require("various-textobjs")
            local keymap = require("lib.utils").keymap

            various.setup(cfg.opts)

            local inoutMaps = {
                subword = "s",
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
                restOfIndentation = "R",
                column = "|",
                entireBuffer = "gG",
                url = "L",
            }

            for fn, map in pairs(oneMaps) do
                keymap({ "o", "x" }, map, function() various[fn]() end, nil, "[TOBJ] " .. fn)
            end

            local opMode = {
                entireBuffer = "<C-a>",
                toNextQuotationMark = '"',
            }

            for fn, map in pairs(opMode) do
                keymap({ "o" }, map, function() various[fn]() end, nil, "[TOBJ] " .. fn)
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
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", },
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
                    c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
                    C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            })
        end,
    },

    {
        "ziontee113/syntax-tree-surfer",
        name = "sts",
        config = true,
        cmd = { "STSSelectMasterNode", "STSSelectCurrentNode", "STSSelectNextSiblingNode", "STSSelectPrevSiblingNode", "STSSelectNextSiblingNode", "STSSelectPrevSiblingNode", "STSSelectParentNode", "STSSelectChildNode", "STSSelectParentNode", "STSSelectChildNode", "STSSwapPrevVisual", "STSSwapNextVisual", },
        branch = "2.1",
        keys = {
            -- { mode = "n", "vx",      cmd("STSSelectMasterNode"),      keymap_opts },
            -- { mode = "n", "vn",      cmd("STSSelectCurrentNode"),     keymap_opts },
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
        }
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
    },
    {
        "chrisgrieser/nvim-scissors",
        event = "InsertEnter",
        opts = {
            snippetDir = vim.fn.stdpath("config") .. "/snippets",
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
    {
        "davidmh/mdx.nvim",
        ft = { "mdx" },
        config = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
}
