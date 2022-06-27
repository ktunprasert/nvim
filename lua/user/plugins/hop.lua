local hop = require 'hop'
local keymap = require 'lib.utils'.keymap

hop.setup()

local hop_options = { silent = true }

keymap("n", "<Tab>s", ":HopChar1<CR>", hop_options)
keymap("n", "<Tab>d", ":HopChar2<CR>", hop_options)
keymap("n", "<C-f>", ":HopChar2<CR>", hop_options)

keymap("n", "<Tab>w", ":HopWordCurrentLine<CR>", hop_options)
keymap("n", "<Tab>W", ":HopWord<CR>", hop_options)

keymap("n", "<Tab>h", ":HopAnywhereCurrentLineBC<CR>", hop_options)
keymap("n", "<Tab>l", ":HopAnywhereCurrentLineAC<CR>", hop_options)

keymap("n", "<Tab>k", ":HopLineBC<CR>", hop_options)
keymap("n", "<Tab>j", ":HopLineAC<CR>", hop_options)

keymap("n", "<Tab>g", ":HopAnywhere<CR>", hop_options)
keymap("n", "<Tab>G", ":HopAnywhereMW<CR>", hop_options)

keymap("n", "<Tab>/", ":HopPattern<CR>", hop_options)
keymap("n", "<Tab>f", ":HopPattern<CR>", hop_options)
