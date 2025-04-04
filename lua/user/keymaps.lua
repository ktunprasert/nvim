local keymap = require('lib.utils').keymap

-- Space as <Leader>
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   n : Normal
--   i : Insert
--   v : Visual
--   x : Visual Block
--   t : Term(inal)
--   c : Command
--   o : Operation

-- Append ; or , at end of line in insert mode
-- also keeps the cursor editing at current place
keymap("i", "<A-;>", "<Esc>mz<Esc>A;<Esc>`za")
keymap("i", "<A-,>", "<Esc>mz<Esc>A,<Esc>`za")
keymap("n", "<A-;>", "<Esc>mz<Esc>A;<Esc>`za<Esc>")
keymap("n", "<A-,>", "<Esc>mz<Esc>A,<Esc>`za<Esc>")
-- Same but for newlines
keymap("i", "<A-n>", "<Esc>mz<Esc>o<Esc>`za")
keymap("i", "<A-S-n>", "<Esc>mz<Esc>O<Esc>`za")
keymap("n", "<A-n>", "<Esc>mz<Esc>o<Esc>`za<Esc>")
keymap("n", "<A-S-n>", "<Esc>mz<Esc>O<Esc>`za<Esc>")

-- Ctrl + S to save file :)
keymap("n", "<C-s>", ":w<CR>")

-- Force create file if doesn't exist
keymap("", "gf", ":e <cfile><CR>")

-- Command mode without shift
keymap("n", ";", ":")
keymap("v", ";", ":")

-- Replay macro
keymap("n", ",,", "@@")

-- Quickly escape from insert mode
keymap("i", "jk", "<Esc>")

-- Force paste from yank with comma
keymap("n", ",p", "\"0p")
keymap("n", ",P", "\"0P")

-- Zen Mode
keymap("n", "<A-f>", "<cmd>ZenMode<CR>")
keymap("n", "<A-g>", "<cmd>NoNeckPain<CR>")
keymap("n", "1<A-f>", function()
    require("zen-mode").toggle({
        window = {
            width = 100,
            options = { wrap = true }
        }
    })
end)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Harpoon
keymap("n", "<A-h>", function() require("harpoon.ui").nav_prev() end)
keymap("n", "<A-l>", function() require("harpoon.ui").nav_next() end)

-- Easily split vert and horizontal
keymap("n", "<C-\\>", ":vs<CR>")
keymap("n", "<C-_>", ":sp<CR>")

-- Better tab navigations
keymap("n", "<A-Right>", "gt")
keymap("n", "<A-Left>", "gT")

-- Toggle File Explorer
-- keymap("n", "<C-e>", ":Neotree last position=right focus<CR>")
-- keymap("n", "<C-e>", ":Neotree last focus<CR>")
keymap("n", "<C-e>", function()
    require("edgy").toggle()
    vim.schedule(function() require("edgy").goto_main() end)
end)

keymap("n", "<Leader>e", ":Neotree focus<CR>")
keymap("n", "<A-e>", ":Neotree toggle position=float filesystem<CR>")

keymap("n", "<C-p>", ":Telescope find_files<CR>")

-- Navigate buffers
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>")
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>")

local jumpbuf = function(n)
    return ":lua require('bufferline').go_to_buffer(" .. n .. ", false)<CR>"
end
keymap("n", "<A-1>", jumpbuf(1))
keymap("n", "<A-2>", jumpbuf(2))
keymap("n", "<A-3>", jumpbuf(3))
keymap("n", "<A-4>", jumpbuf(4))
keymap("n", "<A-5>", jumpbuf(5))
keymap("n", "<A-6>", jumpbuf(6))
keymap("n", "<A-7>", jumpbuf(7))
keymap("n", "<A-8>", jumpbuf(8))
keymap("n", "<A-9>", jumpbuf(9))

-- Kill Window
keymap("n", "<Leader>x", "<C-w>q")

-- Easy indent (or just spam '=')
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move lines up and down
-- Normal --
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("n", "<A-j>", ":m .+<CR>==")
-- Insert --
keymap("i", "<A-k>", "<Esc>:m -2<CR>==gi")
keymap("i", "<A-j>", "<Esc>:m +<CR>==gi")
-- Visual --
keymap("v", "<A-k>", ":m '<-2<CR>==gv")
keymap("v", "<A-j>", ":m '>+1<CR>==gv")

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +4<CR>")
keymap("n", "<C-Down>", ":resize -4<CR>")
keymap("n", "<C-Left>", ":vert resize -4<CR>")
keymap("n", "<C-Right>", ":vert resize +4<CR>")

-- Edit config from anywhere
keymap("n", "<Leader><Leader>ec", "<cmd>exe 'edit' stdpath('config')<CR>")
keymap("n", "<Leader><Leader>ed", "<cmd>exe 'cd' stdpath('config')<CR>")

-- Clear all the search highlight from the screen
keymap("n", "<F5>", "<cmd>noh<CR>")

-- Return current buffer to last edited stage
keymap("n", "<C-Del>", "<cmd>e!<CR>")

-- Context up
keymap("n", "<BS>", function() require("barbecue.ui").navigate(-1) end)

-- Quickfix with fallback to loclist
local utils = require("lib.utils")
keymap("n", "(", utils.smart_qf_navigation("prev"), nil, "Navigate to previous quickfix or loclist item")
keymap("n", ")", utils.smart_qf_navigation("next"), nil, "Navigate to next quickfix or loclist item")

-- C-l as delete key
keymap("i", "<C-l>", "<Del>")

keymap("n", "<A-Up>", "<cmd>GUIFontSizeUp<CR>")
keymap("n", "<A-Down>", "<cmd>GUIFontSizeDown<CR>")
keymap("n", "<A-0>", "<cmd>GUIFontSizeSet<CR>")

-- LSPs
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
keymap("n", "<Leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
keymap("n", "<F3>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
keymap("n", "gh", "<cmd>lua vim.diagnostic.open_float()<CR>")
keymap("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
keymap("n", "gl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>')
