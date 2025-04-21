-- Treesitter functions
local M = {}

-- Function to traverse up the TreeSitter node hierarchy
M.ts_parent_node = function()
    -- print("hi")
    local ts_utils = require('nvim-treesitter.ts_utils')
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

    -- Optionally highlight the node
    -- ts_utils.update_selection(0, parent)

    -- Return the parent node in case further processing is needed
    return parent
end

return M
