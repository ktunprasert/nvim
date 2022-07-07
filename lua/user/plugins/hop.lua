local ok, hop = pcall(require, "hop")
if not ok then
    return
end

local keymap = require 'lib.utils'.keymap

hop.setup {
    case_insensitive = false,
}

local hop_options = { silent = true }
local modes = { "n", "v" }

keymap(modes, "<Tab>s", "<cmd>HopChar2<CR>", hop_options)
keymap(modes, "<Tab>d", "<cmd>HopChar2<CR>", hop_options)
keymap(modes, "<Tab><Space>", "<cmd>HopChar2<CR>", hop_options)

keymap(modes, "<Tab>w", "<cmd>HopWordCurrentLine<CR>", hop_options)
keymap(modes, "<Tab>W", "<cmd>HopWord<CR>", hop_options)
keymap(modes, "<Tab><Tab>", "<cmd>HopWord<CR>", hop_options)

keymap(modes, "<Tab>h", "<cmd>HopAnywhereCurrentLineBC<CR>", hop_options)
keymap(modes, "<Tab>l", "<cmd>HopAnywhereCurrentLineAC<CR>", hop_options)

keymap(modes, "<Tab>k", "<cmd>HopLineBC<CR>", hop_options)
keymap(modes, "<Tab>j", "<cmd>HopLineAC<CR>", hop_options)
keymap(modes, "<Tab>0", "<cmd>HopLine<CR>", hop_options)
keymap(modes, "<Tab><CR>", "<cmd>HopLineMW<CR>", hop_options)

keymap(modes, "<Tab>g", "<cmd>HopWordMW<CR>", hop_options)

keymap(modes, "<Tab>/", "<cmd>HopPattern<CR>", hop_options)

keymap(modes, "<Tab>f", "<cmd>HopChar1CurrentLineAC<CR>", hop_options)
keymap(modes, "<Tab>F", "<cmd>HopChar1CurrentLineBC<CR>", hop_options)

keymap(modes, "<Tab>t", "<cmd>HopChar2CurrentLineAC<CR>", hop_options)
keymap(modes, "<Tab>T", "<cmd>HopChar2CurrentLineBC<CR>", hop_options)

keymap(modes, "f", "<cmd>HopChar1CurrentLineAC<CR>", hop_options)
keymap(modes, "F", "<cmd>HopChar1CurrentLineBC<CR>", hop_options)

local hint = require "hop.hint"

keymap(modes, "t", function()
    hop.hint_char1({
        hint_offset = -1,
        direction = hint.HintDirection.AFTER_CURSOR,
        current_line_only = true,
    })
end, hop_options)

keymap(modes, "T", function()
    hop.hint_char1({
        hint_offset = -1,
        direction = hint.HintDirection.BEFORE_CURSOR,
        current_line_only = true,
    })
end, hop_options)

keymap(modes, "<Tab>$", function()
    hop.hint_lines()
    vim.schedule(function()
        vim.cmd([[normal $]])
    end)
end, hop_options)

keymap(modes, "<Tab>e", function()
    hop.hint_words({
        hint_position = hint.HintPosition.END,
        current_line_only = true,
    })
end, { silent = true, desc = "Hop end of word current line" })

keymap(modes, "<Tab>E", function()
    hop.hint_words({
        hint_position = hint.HintPosition.END,
    })
end, { silent = true, desc = "Hop end of word global buffer" })
