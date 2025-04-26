local keymap = require('lib.utils').keymap

vim.opt_local.shiftwidth = 4

-- source current file
keymap("n", "<F6>", require('lib.utils').cmdcr("source"))

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua",
    callback = function(tbl)
        if tbl.match:match("/.local/share/nvim/") then
            return false
        end

        vim.cmd("Format")
    end,
})
