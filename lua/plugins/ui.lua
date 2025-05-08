local cmd = require("lib.utils").cmdcr

return {
    {
        "akinsho/bufferline.nvim",
        branch = "main",
        event = "BufEnter",
        dependencies = "kyazdani42/nvim-web-devicons",
        opts = {
            options = {
                numbers = function(opts)
                    return string.format('%s{%s}', opts.raise(opts.ordinal), opts.id)
                end,
                separator_style = "thin",
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                sort_by = "relative_directory",
            }
        }
    },
    {
        "shortcuts/no-neck-pain.nvim",
        cmd = "NoNeckPain",
        keys = {
            { "<A-g>", cmd("NoNeckPain") },
        },
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
        "echasnovski/mini.hipatterns",
        -- PERF: for some reason it is slower to include filetype
        -- ft = { "lua", "html", "css", "scss", "javascript", "typescript", "typescriptreact" },
        config = function()
            local hptn = require("mini.hipatterns")
            hptn.setup({
                highlighters = { hex_color = require("mini.hipatterns").gen_highlighter.hex_color(), },
                delay = { text_change = 500 },
            })
        end,
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
        "sphamba/smear-cursor.nvim",
        event = "CursorMoved",
        opts = {
            stiffness = .8,
            trailing_stiffness = .5,
            distance_stop_animating = .5,
            smear_to_cmd = false,
            cterm_cursor_colors = { 240, 245, 250, 255 },
            cterm_bg = 235,
            -- cursor_color = "#D7A933",
        },
    },
}
