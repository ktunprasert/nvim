local ok, hop = pcall(require, "hop")
if not ok then
    return
end

local sok, sts = pcall(require, "syntax-tree-surfer")
if not sok then
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

local function hop_keymap(km, exec, opts)
    local _opts = hop_options
    if opts then
        _opts = vim.tbl_deep_extend("force", hop_options, opts)
    end
    return keymap(modes, hop_leader .. km, exec, _opts)
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

hop_keymap("a", function()
    sts.targeted_jump({
        "arguments",
        "field"
    })
end, { desc = "Hop to closest field or arguments" })

hop_keymap("c", function()
    sts.targeted_jump({
        "identifier",
        "comment",
        "chunk"
    })
end, { desc = "Hop to closest node or comment" })

hop_keymap("v", function()
    sts.targeted_jump({
        "variable_declaration"
    })
end, { desc = "Hop to closest variable" })

hop_keymap("f", function()
    sts.targeted_jump({
        "function",
        "arrrow_function",
        "function_definition"
    })
end, { desc = "Hop to closest function" })

hop_keymap("i", function()
    sts.targeted_jump({
        "if_statement",
        "else_cause",
        "else_statement",
        "elseif_statement",
        "for_statement",
        "while_statement",
        "switch_statement"
    })
end, { desc = "Hop to closest control block" })

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
