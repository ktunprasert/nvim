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

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Easily split vert and horizontal
keymap("n", "<C-\\>", ":vs<CR>")
keymap("n", "<C-_>", ":sp<CR>")

-- Better tab navigations
keymap("n", "<A-Right>", "gt")
keymap("n", "<A-Left>", "gT")

-- Toggle File Explorer
keymap("n", "<C-e>", ":NvimTreeFocus<CR>")
keymap("n", "<Leader>e", ":NvimTreeFocus<CR>")

keymap("n", "<C-p>", ":Telescope find_files<CR>")

-- Navigate buffers
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>")
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>")

local jumpbuf = function(n)
    return ":lua require('bufferline').go_to_buffer(" .. n .. ")<CR>"
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
keymap("n", "<A-10>", jumpbuf(10))

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

-- Append ; or , at end of line in insert mode
-- also keeps the cursor editing at current place
-- keymap("i", ";;", "<Esc>mz<Esc>A;<Esc>`zi")
-- keymap("i", ",,", "<Esc>mz<Esc>A,<Esc>`zi")

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +2<CR>")
keymap("n", "<C-Down>", ":resize -2<CR>")
keymap("n", "<C-Left>", ":vert resize -2<CR>")
keymap("n", "<C-Right>", ":vert resize +2<CR>")

-- Edit config from anywhere
keymap("n", "<Leader><Leader>ec", "<cmd>exe 'edit' stdpath('config')<CR>")
keymap("n", "<Leader><Leader>ed", "<cmd>exe 'cd' stdpath('config')<CR>")

-- Clear all the search highlight from the screen
keymap("n", "<F5>", "<cmd>noh<CR>")

-- Change the suggestion scrolling - toggling suggestion with Ctrl + Space in Insert mode
-- Insert --
vim.keymap.set("i", "<C-Space>", function() return vim.fn.pumvisible() == 0 and '<C-N>' or '<C-Space>' end, {expr = true})
vim.keymap.set("i", "<Tab>", function() return vim.fn.pumvisible() == 1 and '<C-N>' or '<Tab>' end, {expr = true})
vim.keymap.set("i", "<S-Tab>", function() return vim.fn.pumvisible() == 1 and '<C-P>' or '<S-Tab>' end, {expr = true})
vim.keymap.set("i", "<C-j>", function() return vim.fn.pumvisible() == 1 and '<C-N>' or '<C-j>' end, {expr = true})
vim.keymap.set("i", "<C-k>", function() return vim.fn.pumvisible() == 1 and '<C-P>' or '<C-k>' end, {expr = true})

-- -- Command --
vim.keymap.set("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true})
vim.keymap.set("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true})
