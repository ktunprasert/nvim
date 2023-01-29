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

function hop_keymap(km, exec)
    return keymap(modes, hop_leader .. km, exec, hop_options)
end

hop_keymap("s", "<cmd>HopChar2<CR>")
hop_keymap("d", "<cmd>HopChar2<CR>")
hop_keymap("<Space>", "<cmd>HopChar2<CR>")

hop_keymap("w", "<cmd>HopWordCurrentLine<CR>")
hop_keymap("W", "<cmd>HopWord<CR>")
hop_keymap(hop_leader, "<cmd>HopWord<CR>")

hop_keymap("h", "<cmd>HopAnywhereCurrentLineBC<CR>")
hop_keymap("l", "<cmd>HopAnywhereCurrentLineAC<CR>")

hop_keymap("k", "<cmd>HopLineBC<CR>")
hop_keymap("j", "<cmd>HopLineAC<CR>")
hop_keymap("0", "<cmd>HopLine<CR>")
hop_keymap("<CR>", "<cmd>HopLineMW<CR>")

hop_keymap("g", "<cmd>HopWordMW<CR>")

hop_keymap("/", "<cmd>HopPattern<CR>")

hop_keymap("f", "<cmd>HopChar1CurrentLineAC<CR>")
hop_keymap("F", "<cmd>HopChar1CurrentLineBC<CR>")

hop_keymap("t", "<cmd>HopChar2CurrentLineAC<CR>")
hop_keymap("T", "<cmd>HopChar2CurrentLineBC<CR>")

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
