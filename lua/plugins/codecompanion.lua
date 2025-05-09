return {
    {
        "olimorris/codecompanion.nvim",
        opts = {
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
                agent = {
                    adapter = "copilot",
                },
            },
            adapters = {
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = "gemini-2.5-pro-preview-05-06"
                            }
                        }
                    })
                end
            },
            log_level = "debug",
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        picker = "snacks",
                    },
                },
            },
            display = {
                chat = {
                    auto_scroll = true,
                },
            },
        },
        cmd = {
            "CodeCompanionActions",
            "CodeCompanion",
            "CodeCompanionChat",
            "CodeCompanionCmd",
            "CodeCompanionHistory",
        },
        keys = {
            { "<Leader>aa", "<cmd>CodeCompanionActions<cr>",     desc = "[CC] Actions", mode = { "n", "v" } },
            { "<Leader>ae", "<cmd>CodeCompanion /et<cr>",        desc = "[CC] Edit",    mode = { "n", "v" } },
            { "<Leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "[CC] Toggle",  mode = { "n", "v" } },
            { "<Leader>ac", "<cmd>CodeCompanionChat Add<cr>",    desc = "[CC] Add",     mode = { "v" } },
            { "<Leader>ah", "<cmd>CodeCompanionHistory<cr>",     desc = "[CC] History", mode = { "n", "v" } },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/codecompanion-history.nvim",
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "codecompanion" },
                    debounce = 2000,
                    overrides = {
                        buftype = {
                            nofile = {
                                code = { left_pad = 0, right_pad = 0 },
                            },
                        },
                    },
                },
                ft = { "markdown", "codecompanion" },
            },
        },

    },
}
