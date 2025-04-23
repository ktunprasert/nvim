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
    options = {
        left = { size = .4 },
        right = { size = .2 },
    },
    left = {
        { ft = "help", }, { ft = "man", },
    },
    wo = {
        winfixwidth = false,
    },
    right = {
        -- {
        --     title = "Files",
        --     ft = "neo-tree",
        --     filter = function(buf_n)
        --         local buf = vim.b[buf_n]
        --         return buf.neo_tree_source == "filesystem" and buf.neo_tree_position ~= "float"
        --     end,
        --     pinned = true,
        --     collapsed = false,
        --     open = "Neotree position=bottom filesystem dir=."
        -- },
        -- {
        --     title = "Buffers",
        --     ft = "neo-tree",
        --     filter = function(buf_n)
        --         local buf = vim.b[buf_n]
        --         return buf.neo_tree_source == "buffers"
        --     end,
        --     pinned = true,
        --     collapsed = true,
        --     open = "Neotree position=right buffers",
        -- },
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
        {
            title = "Treesitter Inspect",
            ft = "query",
            open = "InspectTree",
        },
    },
    bottom = {
        {
            title = "Quickfix",
            ft = "qf",
            open = "cope"
        },
    },
    keys = {
        ["<c-w>="] = function(win)
            win.view.edgebar:equalize()
        end,
        ["="] = function(win)
            win:resize("width", 2)
        end,
        -- decrease width
        ["_"] = function(win)
            win:resize("width", -2)
        end,

    },
}

edgy.setup(opts)
