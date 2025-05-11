vim.opt.fileformat = "unix"
vim.g.neovide_refresh_rate = 144
vim.keymap.set('n', '<C-v>', '"+P')         -- Paste normal mode
vim.keymap.set('v', '<C-v>', '"+P')         -- Paste visual mode
vim.keymap.set('c', '<C-v>', '<C-R>+')      -- Paste command mode
vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode

vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
