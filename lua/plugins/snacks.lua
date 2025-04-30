---@diagnostic disable: missing-fields
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        ---@diagnostic disable-next-line: undefined-global
        { "<leader>.",  function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
        { "<leader>'",  function() Snacks.scratch({ ft = "markdown" }) end,   desc = "Toggle Scrach Todo" },
        { "<leader>S",  function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
        { "<A-f>",      function() Snacks.zen({ win = { width = 0.8 } }) end, desc = "Zen Mode" },
        { "1<A-f>",     function() Snacks.zen({ win = { width = 100 } }) end, desc = "Zen Mode (less width)" },
        { "<leader>sH", function() Snacks.notifier.show_history() end,        desc = "Show notifier history" },
    },
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        scratch = {
            win = {
                style = "scratch",
                noautocmd = true,
                minimal = true,
            },
            win_by_ft = {
                lua = {
                    keys = {
                        ["source"] = {
                            "<cr>",
                            function(self)
                                local name = "scratch." ..
                                    vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                                Snacks.debug.run({ buf = self.buf, name = name })
                            end,
                            desc = "Source buffer",
                            mode = { "n", "x" },
                        },
                    },
                },
                go = {
                    keys = {
                        ["source"] = {
                            "<cr>",
                            function(self)
                                -- TODO: ensure we set this up properly
                                local name = "scratch." ..
                                    vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                                -- Snacks.debug.run({ buf = self.buf, name = name })
                                vim.cmd("$r!echo -n '//' && go run %")
                            end,
                            desc = "Print at bottom",
                            mode = { "n", "x" },
                        },
                    },
                },
            },
        },
        zen = {
            toggles = {
                dim = false,
            },
            minimal = true,
        },
        statuscolumn = {},
        -- TODO: also include search count in notifier keepalive somehow
        notifier = {
            style = "minimal",
            top_down = false,
            margin = { bottom = 1, right = 0 },
            filter = function()
                return true
            end,
        },
        indent = {
            chunk = {
                enabled = true,
                only_current = true,
            },
            animate = {
                enabled = false,
            },
            scope = {
                underline = true,
                only_current = true,
            },
        },
        dim = {
            enabled = false,
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.dd = Snacks.debug.inspect
                _G.bt = Snacks.debug.backtrace
                vim.print = dd
                vim.api.nvim_create_autocmd("LspProgress", {
                    callback = function(ev)
                        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                        vim.notify(vim.lsp.status(), "info", {
                            id = "lsp_progress",
                            title = "LSP Progress",
                            opts = function(notif)
                                notif.icon = ev.data.params.value.kind == "end" and " "
                                    ---@diagnostic disable-next-line: undefined-field
                                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                            end,
                        })
                    end,
                })
                vim.print("loaded")

                Snacks.toggle.dim():map("<leader>ud")
                Snacks.toggle.treesitter():map("<leader>ut")
            end,
        })
    end
}
