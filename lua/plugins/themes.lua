return {
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
            require("gruvbox").setup {
                contrast = "hard",
                overrides = {
                    SignColumn = { bg = "none" },
                },
            }
            -- vim.cmd([[colorscheme gruvbox]])
        end,
        enabled = false,
    },
    {
        "ficcdaf/ashen.nvim",
        -- optional but recommended,
        -- pin to the latest stable release:
        -- tag = "*",
        lazy = false,
        priority = 1000,
        -- configuration is optional!
        opts = {
            style_presets = {
                bold_functions = true,
                italic_comments = true,
            },
            transparent = TRANSPARENT,
        },

        config = function(cfg)
            require("ashen").setup(cfg.opts)
            vim.cmd("colorscheme ashen")
        end
    }
}
