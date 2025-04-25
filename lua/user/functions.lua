-- Treesitter functions
local M = {}

M.ts_parent_node = function()
    local ts_utils = require('nvim-treesitter.ts_utils')

    -- Get current cursor position before any movement
    local initial_pos = vim.api.nvim_win_get_cursor(0)

    -- If we're already leftmost we stop
    if initial_pos[2] == 0 then
        return
    end

    local current_node = ts_utils.get_node_at_cursor()
    if not current_node then
        print("No treesitter node found at cursor position")
        return
    end

    local parent = current_node:parent()
    if not parent then
        print("No parent node available")
        return
    end

    -- Move cursor to the parent node
    ts_utils.goto_node(parent)

    -- Check if cursor position has changed
    local new_pos = vim.api.nvim_win_get_cursor(0)
    if new_pos[1] == initial_pos[1] and new_pos[2] == initial_pos[2] then
        -- Cursor didn't move, try going left by one and try again
        local col = initial_pos[2]
        if col > 0 then
            -- Move cursor left by one
            vim.api.nvim_win_set_cursor(0, { initial_pos[1], col - 1 })

            -- Try the function again recursively
            return M.ts_parent_node()
        end
    end

    -- Return the parent node in case further processing is needed
    return parent
end

return M
