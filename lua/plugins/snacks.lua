---@diagnostic disable: missing-fields
---
local cwd_opts = {
    filter = {
        paths = {
            [vim.fn.getcwd()] = true,
        },
    },
}
return {
    "folke/snacks.nvim",
    dependencies = {
        "folke/flash.nvim",
    },
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
        -- { "<leader>;",  function() Snacks.lazygit() end,                      desc = "LazyGit" },

        -- pickers - replacing telescope
        { "<Leader>1",  function() Snacks.picker.resume() end,                desc = "Resume" },
        { "<Leader>R",  function() Snacks.picker.recent() end,                desc = "Recent Files (Global)" },
        { "<Leader>r",  function() Snacks.picker.recent(cwd_opts) end,        desc = "Recent Files" },

        { "<Leader>sh", function() Snacks.picker.help() end,                  desc = "Help" },
        { "<Leader>sa", function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
        { "<Leader>sp", function() Snacks.picker.projects() end,              desc = "Projects" },
        { "<Leader>sg", function() Snacks.picker.git_files() end,             desc = "Git Files" },
        { "<leader>se", function() Snacks.picker.explorer() end,              desc = "Explorer" },
        { "<Leader>sf", function() Snacks.picker.lines() end,                 desc = "Search Lines" },
        { "<leader>st", function() Snacks.picker.grep() end,                  desc = "Grep" },
        {
            "<Leader>sb",
            function()
                Snacks.picker.buffers({
                    current = true,
                    win = {
                        input = {
                            keys = {
                                ["<C-d>"] = { "bufdelete", mode = { "n", "i" } },
                            }
                        }
                    }
                })
            end,
            desc = "Buffers"
        },
        { "<Leader>sB", function() Snacks.picker.grep_buffers() end,       desc = "Search Buffers" },
        { "<Leader>sk", function() Snacks.picker.keymaps() end,            desc = "Keymaps" },
        { '<Leader>s"', function() Snacks.picker.registers() end,          desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end,     desc = "Search History" },
        { "<leader>s:", function() Snacks.picker.lazy() end,               desc = "Search for Plugin Spec" },
        { "<Leader>sP", function() Snacks.picker.colorschemes() end,       desc = "Colourscheme Preview" },
        { "<Leader>sc", function() Snacks.picker.commands() end,           desc = "Commands" },
        { "<Leader>sC", function() Snacks.picker.command_history() end,    desc = "Command History" },
        { "<Leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostic Buffer" },
        { "<Leader>sD", function() Snacks.picker.diagnostics() end,        desc = "Diagnostqc" },
        { "<Leader>sq", function() Snacks.picker.qflist() end,             desc = "Quickfix List" },
        { "<Leader>sL", function() Snacks.picker.lsp_config() end,         desc = "LSP Config" },
        {
            "<Leader>sl",
            function()
                Snacks.picker.highlights({
                    confirm = { "yank", "close" } })
            end,
            desc = "Highlights"
        },
        { "<leader>sw", function() Snacks.picker.grep_word():word() end,      desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>so", function() Snacks.picker.lsp_symbols() end,           desc = "Document Symbols" },
        { "<leader>sO", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
        { "<leader>si", function() Snacks.picker.icons() end,                 desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end,                 desc = "Jumps" },
        { "<Leader>sr", function() Snacks.picker.lsp_references() end,        desc = "References" },
        -- {
        --     "<leader>sm",
        --     function()
        --         Snacks.picker.treesitter({ filter = { default = { "Function", "Method" } } })
        --     end,
        --     desc = "Methods"
        -- },
        { "<leader>sm", function() Snacks.picker.treesitter() end,            desc = "Treesitter" },
        { "<leader>su", function() Snacks.picker.undo() end,                  desc = "Undo History" },

        { "<Leader>gf", function() Snacks.picker.git_log_file() end,          desc = "Git Log File" },
        { "<Leader>gb", function() Snacks.picker.git_branches() end,          desc = "Git Branches" },
        { "<Leader>gl", function() Snacks.picker.git_log_line() end,          desc = "Git Log Line" },
        { "<Leader>gc", function() Snacks.picker.git_log() end,               desc = "Git Commits" },
        { "<Leader>gs", function() Snacks.picker.git_status() end,            desc = "Git Status" },
        { "<Leader>gd", function() Snacks.picker.git_diff() end,              desc = "Git Diff" },

        { "<C-p>",      function() Snacks.picker.smart(cwd_opts) end,         desc = "Smart picker" },

        { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
        { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
        { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                     desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
    },
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            layout = {
                preset = "ivy",
            },

            win = {
                input = {
                    keys = {
                        ["<c-space>"] = { "flash", mode = { "n", "i" } },
                        ["s"] = { "flash" },
                        ["<M-j>"] = { "edit_split", mode = { "i", "n" } },
                        [""] = { "toggle_help_list", mode = { "i" } },
                        ["<M-l>"] = { "edit_vsplit", mode = { "i", "n" } },
                    }
                }
            },
            matcher = {
                frecency = true,
            },
            debug = {
                -- scores = true,
            },
            previewers = {
                diff = {
                    builtin = false,
                    cmd = { "delta", "--tabs", "2" },
                },
            },
            actions = {
                flash = function(picker)
                    require("flash").jump({
                        pattern = "^",
                        label = { after = { 0, 0 }, style = "overlay" },
                        search = {
                            mode = "search",
                            exclude = {
                                function(win)
                                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                                end,
                            },
                        },
                        action = function(match)
                            local idx = picker.list:row2idx(match.pos[1])
                            picker.list:_move(idx, true, true)
                            picker:action("confirm")
                        end,
                    })
                end,
            },
        }
        ,
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
            win = {
                wo = { wrap = true }
            },
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
        input = {},
        -- lazygit = {
        --     -- configure = true,
        --     -- theme_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/lg_ashen.yml"),
        --     args = { "-ucf",
        --         string.format(
        --             "%s/lazygit.yml,%s/lg_ashen.yaml",
        --             vim.fn.stdpath("config"),
        --             vim.fn.stdpath("config")
        --         ),
        --     },
        -- },
        scope = {
            enabled = true,
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

                Snacks.toggle.dim():map("<leader>ud")
                Snacks.toggle.treesitter():map("<leader>ut")
            end,
        })
    end
}

-- │fish: command substitutions not allowed in command position. Try var=(your-cmd) $var ...
-- │[ -z "$NVIM" ] && (nvim -- "/root/.config/nvim/lua/plugins/avante.lua") || (nvim --server "$NVIM" --remote-send "q" &&
-- │nvim --server "$NVIM" --remote-tab "/root/.config/nvim/lua/plugins/avante.lua")
