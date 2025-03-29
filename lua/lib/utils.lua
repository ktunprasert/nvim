local M = {}

local default_opts = { noremap = true, silent = true }

-- Shorten function name
local function keymap(mode, key, cmd, options, desc)
    options = options or default_opts

    if desc ~= nil then
        options.desc = desc
    end

    vim.keymap.set(mode, key, cmd, options)
end

local safe_call = function (cmd, arg)
    local ok, _ = pcall(cmd, arg)
    return ok
end

-- Function to navigate quickfix list with fallback to loclist if empty
M.smart_qf_navigation = function(direction)
    return function()
        -- Check if quickfix list is empty
        local qf_is_empty = vim.tbl_isempty(vim.fn.getqflist())
        -- vim.fn.getloclist

        if qf_is_empty then
            -- Fallback to loclist if quickfix is empty
            if direction == "next" then
                safe_call(vim.cmd, "lnext")
            else
                safe_call(vim.cmd, "lprev")
            end
        else
            -- Use quickfix list
            if direction == "next" then
                safe_call(vim.cmd, "cnext")
            else
                safe_call(vim.cmd, "cprev")
            end
        end
    end
end

M.keymap = keymap

M.buf_keymap = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        lhs,
        rhs,
        vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
    )
end

return M
