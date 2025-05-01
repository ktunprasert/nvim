if winblend() == 0 then
    vim.api.nvim_set_hl(0, "WinBar", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "WinBarNC", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "DapUICurrentFrameName", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "AvanteSidebarWinHorizontalSeparator", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "lualine_c_normal", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "lualine_c_inactive", { link = "AshenBackground" })
end

vim.api.nvim_set_hl(0, "LineNr", { link = "AshenG6" })
vim.api.nvim_set_hl(0, "Added", { link = "AshenGreen" })

vim.api.nvim_set_hl(0, "Cursor", { link = "AshenOrangeGolden" })
vim.api.nvim_set_hl(0, "CursorIM", { link = "AshenOrangeGolden" })
vim.api.nvim_set_hl(0, "ICursor", { link = "AshenOrangeGolden" })
vim.api.nvim_set_hl(0, "TermCursor", { link = "AshenOrangeGolden" })
