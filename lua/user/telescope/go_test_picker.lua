-- File: lua/user/go_test_picker.lua
local M = {}

-- Helper function to get test functions using Treesitter (remains the same)
local function get_go_test_functions(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) then
        vim.notify("Invalid buffer provided.", vim.log.levels.WARN)
        return {}
    end
    if vim.bo[bufnr].filetype ~= 'go' then
        vim.notify("Current buffer is not a Go file.", vim.log.levels.INFO)
        return {}
    end
    pcall(require, 'nvim-treesitter.parsers')
    -- if not vim.treesitter.language.is_installed('go') then
    --     vim.notify("Treesitter 'go' parser is not installed.", vim.log.levels.WARN)
    --     return {}
    -- end
    local parser = vim.treesitter.get_parser(bufnr, 'go')
    if not parser then
        vim.notify("Treesitter parser for Go not available for this buffer.", vim.log.levels.WARN)
        return {}
    end
    local query_str = [[
      (function_declaration
        name: (identifier) @function.name)
    ]]
    local query = vim.treesitter.query.parse('go', query_str)
    if not query then
        vim.notify("Failed to parse Treesitter query for Go functions.", vim.log.levels.ERROR)
        return {}
    end
    local root = parser:parse()[1]:root()
    local test_functions = {}
    local seen = {}
    for id, node in query:iter_captures(root, bufnr, 0, -1) do
        local capture_name = query.captures[id]
        if capture_name == "function.name" then
            local func_name = vim.treesitter.get_node_text(node, bufnr)
            if func_name and func_name:match("^Test") and not seen[func_name] then
                table.insert(test_functions, func_name)
                seen[func_name] = true
            end
        end
    end
    table.sort(test_functions)
    return test_functions
end

-- Function to be called by the DAP configuration's 'args' function
function M.pick_go_test_function()
    local test_names = get_go_test_functions()

    if #test_names == 0 then
        vim.notify("No Go test functions (starting with 'Test') found.", vim.log.levels.INFO)
        return "" -- Return empty string if no tests found
    end

    local picker = require("dap.ui").pick_one
    local chosen = picker(test_names, "Select Go Test Function to Debug:")

    if chosen ~= nil and chosen ~= "" then
        local escaped_test_name = "^" .. chosen
        vim.notify("Selected test: " .. chosen .. " (using pattern: " .. escaped_test_name .. ")", vim.log.levels.INFO)
        return escaped_test_name
    else
        -- User cancelled (entered 0, non-number, or Esc) or selection was invalid
        vim.notify("Test selection cancelled or invalid.", vim.log.levels.INFO)
        return "" -- Return empty string as expected by DAP config
    end
end

return M
