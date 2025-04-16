local keymap = require('lib.utils').keymap

vim.opt.shiftwidth = 4

-- source current file
keymap("n", "<F6>", "<cmd>source<CR>")

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(tbl)
        if tbl.match:match("/.local/share/nvim/") then
            return false
        end

        vim.lsp.buf.format()
    end,
})
