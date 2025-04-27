local keymap = require('lib.utils').keymap

vim.opt_local.shiftwidth = 4

-- source current file
keymap("n", "<F6>", require('lib.utils').cmdcr("source"))
