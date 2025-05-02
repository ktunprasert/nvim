-- Treesitter functions
local M = {}

M.ts_parent_node = function()
    local ts_utils = require('nvim-treesitter.ts_utils')

    -- Get current cursor position before any movement
    local initial_pos = vim.api.nvim_win_get_cursor(0)

    -- Get the current node and its parent first
    local current_node = ts_utils.get_node_at_cursor()
    if not current_node then
        print("No treesitter node found at cursor position")
        return
    end

    local parent = current_node:parent()

    -- If we're already leftmost (col 0), only stop if the parent is nil or the root node ("source_file")
    if initial_pos[2] == 0 then
        if not parent or parent:type() == "source_file" then
            -- At col 0 and already at the top or no parent, nowhere to go up.
            return
        end
        -- Otherwise (at col 0 but parent exists and is not root), continue to try moving up.
    end

    -- If we didn't return above, check if a parent exists before trying to move
    if not parent then
        print("No parent node available")
        return
    end

    -- Move cursor to the parent node
    ts_utils.goto_node(parent)

    -- Check if cursor position has changed
    local new_pos = vim.api.nvim_win_get_cursor(0)
    if new_pos[1] == initial_pos[1] and new_pos[2] == initial_pos[2] then
        -- Cursor didn't move. This often means the parent node starts at the same position.
        -- Ascend the tree until we find a parent that starts at a different position.
        local target_parent = parent -- Start with the parent we already found
        local parent_start_row, parent_start_col = target_parent:start()

        while target_parent and parent_start_row == initial_pos[1] - 1 and parent_start_col == initial_pos[2] do
            -- Note: Node positions are 0-indexed, cursor positions are 1-indexed.
            local next_parent = target_parent:parent()
            if not next_parent then
                target_parent = nil -- Reached the root or no more parents
                break
            end
            target_parent = next_parent
            parent_start_row, parent_start_col = target_parent:start()
        end

        -- If we found a suitable ancestor, move to it.
        if target_parent then
            ts_utils.goto_node(target_parent)
            -- Update the parent variable to the one we actually moved to
            parent = target_parent
        else
            -- If we ascended all the way to the root or couldn't find a suitable parent,
            -- we probably can't go further up from here.
            -- We could potentially still try the "move left" as a final fallback,
            -- but let's omit it for now to test the ascending logic.
            -- print("Could not find a parent node with a different start position.")
        end
        -- If we moved, the function continues and returns the new parent.
        -- If we didn't find a target_parent, the original parent is returned below.
    end

    -- Return the parent node in case further processing is needed
    return parent
end

return M
