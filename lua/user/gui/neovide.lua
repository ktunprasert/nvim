local keymap = require("lib.utils").keymap

vim.g.neovide_refresh_rate = 144

keymap("n", "<A-Up>", "<cmd>GUIFontSizeUp<CR>")
keymap("n", "<A-Down>", "<cmd>GUIFontSizeDown<CR>")
keymap("n", "<A-0>", "<cmd>GUIFontSizeSet<CR>")
