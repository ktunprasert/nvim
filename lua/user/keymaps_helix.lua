local keymap = require('lib.utils').keymap
local flash_util = require('lib.flash_util')

-- Helix style normal indent
keymap("n", ">", function()
    local count = vim.v.count1 -- Gets the count (default 1)
    for _ = 1, count do
        vim.cmd('normal! >>')
    end
end)

keymap("n", "<", function()
    local count = vim.v.count1
    for _ = 1, count do
        vim.cmd('normal! <<')
    end
end)

-- Helix goto end of line
keymap({ "n", "v", "x" }, "gl", "$")

-- Helix go to word 2 char
keymap({ "n" }, "gw", flash_util.flash_word)
