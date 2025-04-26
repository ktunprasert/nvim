return {
    {
        "folke/which-key.nvim",
        config = function() require("user.plugins.whichkey") end
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        config = function()
            require('mini.indentscope').setup({
                draw = {
                    delay = 0,
                    animation = require('mini.indentscope').gen_animation.none(),
                },
                options = {
                    try_as_border = true,
                },
                symbol = '│',
            })
        end,
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
        'b0o/incline.nvim',
        enabled = false,
        config = function()
            require("user.plugins.incline")
        end,
        -- Optional: Lazy load Incline
        event = 'VeryLazy',
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            { 'kyazdani42/nvim-web-devicons', opt = true },
            { 'ficcdaf/ashen.nvim' }
        },
        config = function() require("user.plugins.lualine") end

    },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        opts = {
            window = {
                width = 120,
                options = {
                    wrap = true,
                }
            }
        }
    },
    {
        "shortcuts/no-neck-pain.nvim",
        event = "VeryLazy",
        opts = {
            width = 150,
            buffers = {
                scratchPad = {
                    enabled = true,
                },
            }
        },
    },
    {
        "SmiteshP/nvim-navic",
        event = "BufRead",
        init = function()
            vim.g.navic_silence = true
            require("nvim-navic").setup({ highlight = true, depth_limit = 8 })
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
                },
                -- {
                --     filter = {
                --         event = "msg_show",
                --         kind = "search_count",
                --     },
                --     -- opts = { skip = true },
                -- },
            },
            lsp = {
                signature = {
                    enabled = false,
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                    ["vim.lsp.util.stylize_markdown"] = false,
                    ["cmp.entry.get_documentation"] = false,
                },
                hover = {
                    enabled = false,
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
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        ft = { "lua", "html", "css", "scss", "javascript", "typescript", "typescriptreact" },
        opts = {
            "*",
            css = {
                RRGGBBAA = true,
            },
        },
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            local colors = require('ashen.colors')
            require("scrollbar").setup({
                show_in_active_only = true,
                hide_if_all_visible = true,
                max_lines = 1000,
                handle = {
                    color = colors.g_7,
                },
                marks = {
                    Search = { color = colors.orange_glow },
                }
            })
        end
    },

    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        ---@diagnostic disable-next-line: different-requires
        config = function() require("user.plugins.edgy") end,
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        event = "VeryLazy",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            show_dirname = false,
            show_basename = false,
        },
    },
    {
        "sphamba/smear-cursor.nvim",
        event = "CursorMoved",
        opts = {
            stiffness = .8,
            trailing_stiffness = .5,
            distance_stop_animating = .5,
            smear_to_cmd = false,
            cursor_color = "#D7A933",
        },
    },
}
