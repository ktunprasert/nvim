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
    { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
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
    { "tiagovla/tokyodark.nvim" },
    { "rebelot/kanagawa.nvim" },
    {
        "sainnhe/sonokai",
        config = function()
            vim.g.sonokai_style = 'espresso'
            -- vim.cmd([[colorscheme sonokai]])
        end
    },
    {
        "loctvl842/monokai-pro.nvim",
        config = function()
            -- require("monokai-pro").setup({
            --     filter = "spectrum"
            -- })
        end
    },
    -- ██╗     ███████╗██████╗     ██████╗███╗   ███╗██████╗
    -- ██║     ██╔════╝██╔══██╗   ██╔════╝████╗ ████║██╔══██╗
    -- ██║     ███████╗██████╔╝   ██║     ██╔████╔██║██████╔╝
    -- ██║     ╚════██║██╔═══╝    ██║     ██║╚██╔╝██║██╔═══╝
    -- ███████╗███████║██║███████╗╚██████╗██║ ╚═╝ ██║██║
    -- ╚══════╝╚══════╝╚═╝╚══════╝ ╚═════╝╚═╝     ╚═╝╚═╝     ~ LSP and Autocompletion
    -- CMP dependencies
    { "hrsh7th/nvim-cmp", lazy = false }, -- The completion plugin
    { "hrsh7th/cmp-buffer", lazy = false }, -- buffer completions
    { "hrsh7th/cmp-path", lazy = false }, -- path completions
    { "hrsh7th/cmp-cmdline", lazy = false }, -- cmdline completions
    { "saadparwaiz1/cmp_luasnip", lazy = false }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp", lazy = false },
    { "hrsh7th/cmp-nvim-lua", lazy = false },
    { "tzachar/cmp-tabnine", lazy = false, build = './install.sh' },

    -- Snippets engine
    { "L3MON4D3/LuaSnip", lazy = false },
    { "rafamadriz/friendly-snippets", lazy = false },

    -- LSP
    { "neovim/nvim-lspconfig", lazy = false }, -- enable LSP
    { "williamboman/nvim-lsp-installer", lazy = false }, -- simple LSP installer - just werks
    { "nvim-telescope/telescope-ui-select.nvim", lazy = false },
    {
        "ray-x/lsp_signature.nvim",
        lazy = false,
        opts = {
            toggle_key = '<C-k>',
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
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
        config = function(_, _opts)
            local ai = require("mini.ai")
            ai.setup(_opts)
        end,
    },

    {
        "ziontee113/syntax-tree-surfer",
        name = "sts",
        config = true,
        branch = "2.1",
        keys = {
            { mode = "n", "vx", '<cmd>STSSelectMasterNode<cr>', opts },
            { mode = "n", "vn", '<cmd>STSSelectCurrentNode<cr>', opts },

            { mode = "n", "-", function()
                require("syntax-tree-surfer").filtered_jump({
                    "default",
                    "variable_declaration",
                    "short_var_declaration",
                    "identifier",
                }, false)
            end, opts },
            { mode = "n", "+", function()
                require("syntax-tree-surfer").filtered_jump({
                    "default",
                    "variable_declaration",
                    "short_var_declaration",
                    "identifier",
                }, true)
            end, opts },

            { mode = "x", "<Tab>", '<cmd>STSSelectNextSiblingNode<cr>', opts },
            { mode = "x", "<S-Tab>", '<cmd>STSSelectPrevSiblingNode<cr>', opts },

            { mode = "x", "<Down>", '<cmd>STSSelectNextSiblingNode<cr>', opts },
            { mode = "x", "<Up>", '<cmd>STSSelectPrevSiblingNode<cr>', opts },

            { mode = "x", "<Left>", '<cmd>STSSelectParentNode<cr>', opts },
            { mode = "x", "<Right>", '<cmd>STSSelectChildNode<cr>', opts },

            { mode = "x", "<BS>", '<cmd>STSSelectParentNode<cr>', opts },
            { mode = "x", "<CR>", '<cmd>STSSelectChildNode<cr>', opts },

            { mode = "x", "<C-Up>", '<cmd>STSSwapPrevVisual<cr>', opts },
            { mode = "x", "<C-Down>", '<cmd>STSSwapNextVisual<cr>', opts },
            { mode = "x", "<C-Left>", '<cmd>STSSwapPrevVisual<cr>', opts },
            { mode = "x", "<C-Right>", '<cmd>STSSwapNextVisual<cr>', opts },

            { mode = "x", "<A-h>", '<cmd>STSSwapPrevVisual<cr>', opts },
            { mode = "x", "<A-l>", '<cmd>STSSwapNextVisual<cr>', opts },
        }
    },

    -- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
    -- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
    --    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
    --    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
    --    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
    --    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝ ~ Telescope
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-telescope/telescope-live-grep-raw.nvim' },
        },
        config = function() require("user.plugins.telescope") end
    },

    { "nvim-telescope/telescope-hop.nvim" },

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
            -- ignores empty lines
            ignore = "^$",

            mappings = {
                basic = true,
                extra = false,
            },
        }
        -- config = function() require("user.plugins.comment") end
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
        opts = {
            show_current_context = true,
            show_current_context_start = true,
            filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
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
        opts = {
            log_level = 'info',
            pre_save_cmds = { "NeoTreeClose" },
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
        "xiyaowong/nvim-transparent",
        cond = false,
        -- config = function() require("transparent").setup({ enable = false }) end,
    },
    {
        "jinh0/eyeliner.nvim",
        lazy = false,
        dependencies = {
            "ellisonleao/gruvbox.nvim",
        },
        config = function() require("user.plugins.eyeliner") end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            {
                's1n7ax/nvim-window-picker',
                name = "window-picker",
                version = "v1.*",
                opts = {
                    autoselect_one = true,
                    include_current = false,
                    selection_chars = 'ABCDEFGHIJK',
                    filter_rules = {
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },

                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { 'terminal' },
                        },
                    },
                    other_win_hl_color = '#e35e4f',
                }
            }
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
        lazy = false,
        opts = {
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
            },
            messages = {
                view = "mini",
            },
            notify = {
                enabled = true,
                view = "mini"
            },

            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },

    {
        "s1n7ax/nvim-window-picker",
        opts = {
            selection_chars = "ABCDEFGHIJK",
            include_current_win = true,
            se_winbar = "always",
        },
    },

    {
        "norcalli/nvim-colorizer.lua",
        opts = {
            "*";
            css = {
                RRGGBBAA = true;
            };
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
        "subnut/nvim-ghost.nvim",
        build = ":call nvim_ghost#installer#install()"
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
            { mode = "n", "|", "<Plug>(leap-backward-to)" },
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
            labeled_modes = "v",
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
            { mode = "n", "<Up>", function()
                require("illuminate").goto_prev_reference(true)
            end, "Prev node under cursor" },

            { mode = "n", "<Down>", function()
                require("illuminate").goto_next_reference(true)
            end, "Next node under cursor" }
        },
        init = function()
            require("illuminate").configure({ opts = 200 })
        end
    },

    -- Own Plugins
    {
        "ktunprasert/gui-font-resize.nvim",
        config = true,
    },
}, lazyOpts)
