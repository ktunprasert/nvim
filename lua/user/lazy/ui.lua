return {
    {
        "folke/which-key.nvim",
        config = function() require("user.plugins.whichkey") end
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
        'b0o/incline.nvim',
        config = function()
            require("user.plugins.incline")
        end,
        -- Optional: Lazy load Incline
        event = 'VeryLazy',
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require("user.plugins.lualine") end
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
        "norcalli/nvim-colorizer.lua",
        opts = {
            "*",
            css = {
                RRGGBBAA = true,
            },
        },
    },
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
        "folke/edgy.nvim",
        event = "VeryLazy",
        config = function() require("user.plugins.edgy") end,
    },
}
