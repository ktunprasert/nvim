if winblend() == 0 then
    vim.api.nvim_set_hl(0, "DapUICurrentFrameName", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "AvanteSidebarWinHorizontalSeparator", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "lualine_c_normal", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "lualine_c_inactive", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "Statusline", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "TabLine", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "TabLineFill", { link = "AshenBackground" })
    vim.api.nvim_set_hl(0, "WinBar", { link = "AshenG3" })
    vim.api.nvim_set_hl(0, "WinBarNC", { link = "AshenG3" })
    vim.api.nvim_set_hl(0, "WinSeparator", { link = "AshenG6" })
end

vim.api.nvim_set_hl(0, "LineNr", { link = "AshenG6" })
vim.api.nvim_set_hl(0, "Added", { link = "AshenGreen" })

-- vim.api.nvim_set_hl(0, "Cursor", { link = "AshenOrangeGolden" })
-- vim.api.nvim_set_hl(0, "CursorIM", { link = "AshenOrangeGolden" })
-- vim.api.nvim_set_hl(0, "ICursor", { link = "AshenOrangeGolden" })
-- vim.api.nvim_set_hl(0, "TermCursor", { link = "AshenOrangeGolden" })
