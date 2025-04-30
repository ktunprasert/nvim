local cmd = require("lib.utils").cmdcr

return {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    gt = { "gitcommit", "diff" },
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        current_line_blame = true,
        numhl = true,
    },
    keys = {
        { mode = "n", "]c", cmd("Gitsigns next_hunk"), desc = "Next hunk", expr = true },
        { mode = "n", "[c", cmd("Gitsigns prev_hunk"), desc = "Prev hunk", expr = true },
        { mode = "n", "]g", cmd("Gitsigns next_hunk"), desc = "Next hunk", expr = true },
        { mode = "n", "[g", cmd("Gitsigns prev_hunk"), desc = "Prev hunk", expr = true },
    },
    init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
            callback = function()
                ---@diagnostic disable-next-line: undefined-field
                vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" },
                    {
                        on_exit = function(_, return_code)
                            if return_code == 0 then
                                pcall(vim.api.nvim_del_augroup_by_name, "GitSignsLazyLoad")
                                vim.schedule(function()
                                    require("lazy").load { plugins = { "gitsigns.nvim" } }
                                end)
                            end
                        end
                    }
                )
            end,
        })
    end,
}
