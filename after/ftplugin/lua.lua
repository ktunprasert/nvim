vim.opt.shiftwidth = 4

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(tbl)
        if tbl.match:match("/.local/share/nvim/") then
            return false
        end

        vim.lsp.buf.format()
    end,
})
