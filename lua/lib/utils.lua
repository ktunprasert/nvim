local M = {}

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local function keymap(mode, key, cmd, options, desc)
    if options == nil then
        options = opts
    end

    if desc ~= nil then
        options.desc = desc
    end

    vim.keymap.set(mode, key, cmd, options)
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
