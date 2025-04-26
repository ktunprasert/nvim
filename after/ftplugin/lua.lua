local keymap = require('lib.utils').keymap

vim.opt_local.shiftwidth = 4

-- source current file
keymap("n", "<F6>", require('lib.utils').cmdcr("source"))

local augroup_id = vim.api.nvim_create_augroup("LuaFormat", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_id,
    pattern = "*.lua",
    callback = function(tbl)
        if tbl.match:match("/.local/share/nvim/") then
            return false
        end

        vim.cmd("Format")
    end,
})
