vim.opt_local.shiftwidth = 2

local augroup = vim.api.nvim_create_augroup("typescriptreact", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = { "*.tsx", "*.ts" },
    callback = function() vim.cmd("Format") end,
})
