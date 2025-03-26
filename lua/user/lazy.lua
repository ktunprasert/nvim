local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local opts = { noremap = true, silent = true }
local lazyOpts = {
    install = {
        colorscheme = { "gruvbox" },
    }
}

require("lazy").setup({
    -- ███████╗███████╗████████╗██╗   ██╗██████╗
    -- ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
    -- ███████╗█████╗     ██║   ██║   ██║██████╔╝
    -- ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝
    -- ███████║███████╗   ██║   ╚██████╔╝██║
    -- ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ~ Setup
    { "nvim-lua/popup.nvim" },   -- An implementation of the Popup API from vim in Neovim
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
    { "lewis6991/impatient.nvim", config = function() require("impatient") end },

    -- ████████╗██╗  ██╗███████╗███╗   ███╗███████╗███████╗
    -- ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝██╔════╝
    --    ██║   ███████║█████╗  ██╔████╔██║█████╗  ███████╗
    --    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝  ╚════██║
    --    ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗███████║
    --    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝╚══════╝ ~ Themes
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup { contrast = "hard" }
            vim.cmd([[colorscheme gruvbox]])
        end,
    },

    -- ██╗     ███████╗██████╗     ██████╗███╗   ███╗██████╗
    -- ██║     ██╔════╝██╔══██╗   ██╔════╝████╗ ████║██╔══██╗
    -- ██║     ███████╗██████╔╝   ██║     ██╔████╔██║██████╔╝
    -- ██║     ╚════██║██╔═══╝    ██║     ██║╚██╔╝██║██╔═══╝
    -- ███████╗███████║██║███████╗╚██████╗██║ ╚═╝ ██║██║
    -- ╚══════╝╚══════╝╚═╝╚══════╝ ╚═════╝╚═╝     ╚═╝╚═╝     ~ LSP and Autocompletion
    -- CMP dependencies
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "copilot",
            -- openai = {
            --     endpoint = "https://api.openai.com/v1",
            --     model = "gpt-4o",   -- your desired model (or use gpt-4o, etc.)
            --     timeout = 30000,    -- Timeout in milliseconds, increase this for reasoning models
            --     temperature = 0,
            --     max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            --     --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
            -- },
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
                model = "claude-3.7-sonnet-thought",
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
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
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = true },
            panel = { enabled = false },
            copilot_model = "gpt-4o-copilot",
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            local fmt = require("copilot_cmp.format")

            require("copilot_cmp").setup({
                formatters = {
                    insert_text = fmt.remove_existing,
                },
                event = { "InsertEnter", "LspAttach" },
                fix_pairs = true,
            })

            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        end
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
    {
        "ray-x/lsp_signature.nvim",
        lazy = false,
        opts = {
            toggle_key = '<C-k>',
            bind = true,
            handler_opts = { border = "none" }
        },
    },

    -- Linter/Formatter
    {
        "jose-elias-alvarez/null-ls.nvim", -- for formatters and linter
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
                init = function()
                    -- no need to load the plugin, since we only need its queries
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                end,
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
        init = function()
            local keyopts = { noremap = true, silent = true }
            vim.keymap.set({ 'n', 'o' }, '<Left>', require('tree-climber').goto_prev, keyopts)
            vim.keymap.set({ 'n', 'o' }, '<Right>', require('tree-climber').goto_next, keyopts)
        end,
    },

    {
        "ziontee113/syntax-tree-surfer",
        name = "sts",
        config = true,
        branch = "2.1",
        keys = {
            { mode = "n", "vx",        '<cmd>STSSelectMasterNode<cr>',      opts },
            { mode = "n", "vn",        '<cmd>STSSelectCurrentNode<cr>',     opts },
            { mode = "x", "<Tab>",     '<cmd>STSSelectNextSiblingNode<cr>', opts },
            { mode = "x", "<S-Tab>",   '<cmd>STSSelectPrevSiblingNode<cr>', opts },
            { mode = "x", "<Down>",    '<cmd>STSSelectNextSiblingNode<cr>', opts },
            { mode = "x", "<Up>",      '<cmd>STSSelectPrevSiblingNode<cr>', opts },
            { mode = "x", "<Left>",    '<cmd>STSSelectParentNode<cr>',      opts },
            { mode = "x", "<Right>",   '<cmd>STSSelectChildNode<cr>',       opts },
            { mode = "x", "<BS>",      '<cmd>STSSelectParentNode<cr>',      opts },
            { mode = "x", "<CR>",      '<cmd>STSSelectChildNode<cr>',       opts },
            { mode = "x", "<C-Up>",    '<cmd>STSSwapPrevVisual<cr>',        opts },
            { mode = "x", "<C-Down>",  '<cmd>STSSwapNextVisual<cr>',        opts },
            { mode = "x", "<C-Left>",  '<cmd>STSSwapPrevVisual<cr>',        opts },
            { mode = "x", "<C-Right>", '<cmd>STSSwapNextVisual<cr>',        opts },
            { mode = "x", "<A-h>",     '<cmd>STSSwapPrevVisual<cr>',        opts },
            { mode = "x", "<A-l>",     '<cmd>STSSwapNextVisual<cr>',        opts },
        }
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
    },
    -- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
    -- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
    --    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
    --    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
    --    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
    --    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝ ~ Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-telescope/telescope-live-grep-raw.nvim' },
        },
        config = function() require("user.plugins.telescope") end
    },

    { "nvim-telescope/telescope-hop.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = false },

    -- ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗
    -- ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝
    -- ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║
    --  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝   ~ Utility
    {
        "kylechui/nvim-surround",
        opts = {
            aliases = {
                ["<"] = "t",
            },
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function() require("user.plugins.gitsigns") end
    },
    {
        "folke/which-key.nvim",
        config = function() require("user.plugins.whichkey") end
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
        "nvim-lualine/lualine.nvim",
        dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require("user.plugins.lualine") end
    },
    {
        "akinsho/toggleterm.nvim",
        lazy = false,
        version = '*',
        config = function() require("user.plugins.toggleterm") end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        name = "ibl",
        config = true,
    },
    {
        "akinsho/bufferline.nvim",
        branch = "main",
        dependencies = "kyazdani42/nvim-web-devicons",
        opts = {
            options = {
                numbers = function(opts)
                    return string.format('%s{%s}', opts.raise(opts.ordinal), opts.id)
                end,
                separator_style = "thin",
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                sort_by = "id",
            }
        }
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
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 150,
                options = {
                    wrap = true,
                }
            }
        }
    },
    {
        "shortcuts/no-neck-pain.nvim",
        lazy = false,
        opts = {
            buffers = {
                scratchPad = {
                    enabled = true,
                },
            }
        },
    },
    {
        "jinh0/eyeliner.nvim",
        lazy = false,
        priority = 999,
        config = function() require("user.plugins.eyeliner") end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function() require("user.plugins.neotree") end,
    },

    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
        lazy = false,
        init = function()
            vim.g.navic_silence = true
            require("nvim-navic").setup({ highlight = true, depth_limit = 5 })
            vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end,
    },

    {
        "folke/noice.nvim",
        event = "VimEnter",
        opts = {
            routes = {
                {
                    view = "mini",
                    filter = { event = "msg_showmode" },
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "search_count",
                    },
                    opts = { skip = true },
                },
            },
            lsp = {
                signature = {
                    enabled = false,
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = {
                    opts = {
                        size = {
                            max_width = 150,
                            max_height = 100,
                        }
                    },
                },
            },
            messages = {
                view = "mini",
                view_error = "mini",
                view_warn = "mini",
            },
            notify = {
                enabled = true,
                view = "mini"
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
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
        "norcalli/nvim-colorizer.lua",
        opts = {
            "*",
            css = {
                RRGGBBAA = true,
            },
        },
    },

    {
        "vinnymeller/swagger-preview.nvim",
        lazy = true,
        build = "npm install -g swagger-ui-watcher",
        opts = {
            port = 8989,
            host = "localhost",
        }
    },

    {
    },

    {
        "mg979/vim-visual-multi",
    },

    {
        'b0o/incline.nvim',
        config = function()
            require("user.plugins.incline")
        end,
        -- Optional: Lazy load Incline
        event = 'VeryLazy',
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
    -- ███╗   ██╗ █████╗ ██╗   ██╗██╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
    -- ████╗  ██║██╔══██╗██║   ██║██║██╔════╝ ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
    -- ██╔██╗ ██║███████║██║   ██║██║██║  ███╗███████║   ██║   ██║██║   ██║██╔██╗ ██║
    -- ██║╚██╗██║██╔══██║╚██╗ ██╔╝██║██║   ██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
    -- ██║ ╚████║██║  ██║ ╚████╔╝ ██║╚██████╔╝██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
    -- ╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ~ Navigation
    {
        "phaazon/hop.nvim",
        lazy = true,
        event = "BufRead",
        config = function() require("user.plugins.hop") end
    },
    {
        "chaoren/vim-wordmotion",
        lazy = false,
        init = function() vim.g.wordmotion_prefix = "<Space>" end
    },
    {
        "ggandor/leap.nvim",
        keys = {
            { mode = "n", "\\", "<Plug>(leap-forward-to)" },
            { mode = "n", "|",  "<Plug>(leap-backward-to)" },
        },
        opts = {
            labeled_modes = "v",
        },
    },
    {
        "ggandor/flit.nvim",
        dependencies = "ggandor/leap.nvim",
        opts = {
            keys = { f = 'f', F = 'F', t = 't', T = 'T' },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "nx",
            multiline = true,
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {
                max_highlighted_traversal_targets = 50,
            }
        }
    },
    {
        "RRethy/vim-illuminate",
        keys = {
            {
                mode = "n",
                "<Up>",
                function()
                    require("illuminate").goto_prev_reference(true)
                end,
                "Prev node under cursor"
            },

            {
                mode = "n",
                "<Down>",
                function()
                    require("illuminate").goto_next_reference(true)
                end,
                "Next node under cursor"
            }
        },
        init = function()
            require("illuminate").configure({
                opts = 200,
                filetypes_denylist = {
                    'dirbuf',
                    'dirvish',
                    'fugitive',
                    'text',
                },

            })
        end
    },

    {
        "ThePrimeagen/harpoon",
        lazy = false,
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
        },
    },

    -- Own Plugins
    {
        "petertriho/nvim-scrollbar",
        init = function()
            local colors = require('gruvbox')
            require("scrollbar").setup({
                handle = {
                    color = colors.palette.light4,
                },
                marks = {
                    Search = { color = colors.palette.bright_orange },
                    Error = { color = colors.palette.bright_red },
                    Warn = { color = colors.palette.bright_yellow },
                    Info = { color = colors.palette.bright_blue },
                    Hint = { color = colors.palette.light0 },
                    Misc = { color = colors.palette.faded_purple },
                }
            })

            require("scrollbar.handlers.gitsigns").setup()
        end
    },
    {
        "ktunprasert/gui-font-resize.nvim",
        config = true,
    },
}, lazyOpts)
