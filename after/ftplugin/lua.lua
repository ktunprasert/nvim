vim.opt.shiftwidth = 4

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua" },
    command = "Format",
})
