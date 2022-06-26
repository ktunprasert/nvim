local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
function keymap(mode, key, cmd, options)
    if options == nil then
        options = opts
    end
    vim.api.nvim_set_keymap(mode, key, cmd, options)
end

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

-- Force create file if doesn't exist
keymap("", "gf", "<cfile><CR>")

-- Command mode without shift
keymap("n", ";", ":")
keymap("v", ";", ":")

-- Replay macro
keymap("n", ",,", "@@")

-- Force paste from yank with comma
keymap("n", ",p", "\"0p")
keymap("n", ",P", "\"0P")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

keymap("n", "<Leader>e", ":Lex 30<CR>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Easy indent (or just spam '=')
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Append ; or , at end of line in insert mode
keymap("i", ";;", "<Esc>A;<Esc>")
keymap("i", ",,", "<Esc>A,<Esc>")

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +2<CR>")
keymap("n", "<C-Down>", ":resize -2<CR>")
keymap("n", "<C-Left>", ":vert resize -2<CR>")
keymap("n", "<C-Right>", ":vert resize +2<CR>")

-- Edit config from anywhere
keymap("n", "<Leader><Leader>ec", ":edit stdpath('config').'/init.lua'<CR>")
