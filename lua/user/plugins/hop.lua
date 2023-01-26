local ok, hop = pcall(require, "hop")
if not ok then
    return
end

local keymap = require 'lib.utils'.keymap

hop.setup {
    case_insensitive = false,
}

local hop_options = { silent = true }
local modes = { "n", "v", "o" }

local hop_leader = "<C-Space>"
-- local hop_leader = "<Tab>"

keymap(modes, hop_leader .. "s", "<cmd>HopChar2<CR>", hop_options)
keymap(modes, hop_leader .. "d", "<cmd>HopChar2<CR>", hop_options)
keymap(modes, hop_leader .. "<Space>", "<cmd>HopChar2<CR>", hop_options)

keymap(modes, hop_leader .. "w", "<cmd>HopWordCurrentLine<CR>", hop_options)
keymap(modes, hop_leader .. "W", "<cmd>HopWord<CR>", hop_options)
keymap(modes, hop_leader .. hop_leader, "<cmd>HopWord<CR>", hop_options)

keymap(modes, hop_leader .. "h", "<cmd>HopAnywhereCurrentLineBC<CR>", hop_options)
keymap(modes, hop_leader .. "l", "<cmd>HopAnywhereCurrentLineAC<CR>", hop_options)

keymap(modes, hop_leader .. "k", "<cmd>HopLineBC<CR>", hop_options)
keymap(modes, hop_leader .. "j", "<cmd>HopLineAC<CR>", hop_options)
keymap(modes, hop_leader .. "0", "<cmd>HopLine<CR>", hop_options)
keymap(modes, hop_leader .. "<CR>", "<cmd>HopLineMW<CR>", hop_options)

keymap(modes, hop_leader .. "g", "<cmd>HopWordMW<CR>", hop_options)

keymap(modes, hop_leader .. "/", "<cmd>HopPattern<CR>", hop_options)

keymap(modes, hop_leader .. "f", "<cmd>HopChar1CurrentLineAC<CR>", hop_options)
keymap(modes, hop_leader .. "F", "<cmd>HopChar1CurrentLineBC<CR>", hop_options)

keymap(modes, hop_leader .. "t", "<cmd>HopChar2CurrentLineAC<CR>", hop_options)
keymap(modes, hop_leader .. "T", "<cmd>HopChar2CurrentLineBC<CR>", hop_options)

local hint = require "hop.hint"

keymap(modes, hop_leader .. "$", function()
    hop.hint_lines()
    vim.schedule(function()
        vim.cmd([[normal $]])
    end)
end, hop_options)

keymap(modes, hop_leader .. "e", function()
    hop.hint_words({
        hint_position = hint.HintPosition.END,
        current_line_only = true,
    })
end, { silent = true, desc = "Hop end of word current line" })

keymap(modes, hop_leader .. "E", function()
    hop.hint_words({
        hint_position = hint.HintPosition.END,
    })
end, { silent = true, desc = "Hop end of word global buffer" })
