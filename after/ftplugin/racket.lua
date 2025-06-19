local keymap = require('lib.utils').keymap
keymap("n", "<F6>", function() Snacks.terminal(("racket %s | less"):format(vim.fn.expand("%"))) end)
