local comment_color = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })

local opts = {
    primary = {
        fg = comment_color.fg,
        bold = true,
        underline = true,
    },
}

vim.api.nvim_set_hl(0, 'EyelinerPrimary', opts.primary)
vim.api.nvim_set_hl(0, 'EyelinerSecondary', {})

-- vim.api.nvim_create_autocmd('ColorScheme', {
--     pattern = '*',
--     callback = function()
--         vim.api.nvim_set_hl(0, 'EyelinerPrimary', opts.primary)
--         vim.api.nvim_set_hl(0, 'EyelinerSecondary', {})
--     end,
-- })
