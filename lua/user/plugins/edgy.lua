local ok, edgy = pcall(require, "edgy")
if not ok then
    return
end

vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

local opts = {
    animate = {
        enabled = false,
    },
    left = {
        {
            ft = "help",
            size = { width = 0.3 },
        },
    },
    right = {
        {
            title = "Files",
            ft = "neo-tree",
            filter = function(buf_n)
                local buf = vim.b[buf_n]
                return buf.neo_tree_source == "filesystem" and buf.neo_tree_position ~= "float"
            end,
            pinned = true,
            collapsed = false,
            open = "Neotree position=bottom filesystem dir=."
        },
        {
            title = "Buffers",
            ft = "neo-tree",
            filter = function(buf_n)
                local buf = vim.b[buf_n]
                return buf.neo_tree_source == "buffers"
            end,
            pinned = true,
            collapsed = false,
            open = "Neotree position=right buffers",
            size = { height = 0.2 },
        },
        -- {
        --     title = "Git",
        --     ft = "neo-tree",
        --     filter = function(buf)
        --         return vim.b[buf].neo_tree_source == "git_status"
        --     end,
        --     pinned = true,
        --     collapsed = false,
        --     open = "Neotree position=top git_status",
        -- },
        {
            title = "Outline",
            ft = "Outline",
            pinned = true,
            collapsed = false,
            open = "Outline",
        },
    },
}

edgy.setup(opts)
