vim.opt_local.shiftwidth = 2

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.tsx", "*.ts" },
    callback = function()
        vim.cmd("Format")
    end,
})
