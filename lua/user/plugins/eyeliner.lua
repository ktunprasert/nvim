local comment_color = vim.api.nvim_get_hl_by_name('Comment', true)

local opts = {
    primary = {
        fg = comment_color.foreground,
        bold = true,
        underline = true,
    },
}

vim.api.nvim_set_hl(0, 'EyelinerPrimary', opts.primary)
vim.api.nvim_set_hl(0, 'EyelinerSecondary', {})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, 'EyelinerPrimary', opts.primary)
        vim.api.nvim_set_hl(0, 'EyelinerSecondary', {})
    end,
})
