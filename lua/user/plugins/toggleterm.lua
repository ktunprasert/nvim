local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
    return
end

local keymap = require('lib.utils').keymap

function checkWin()
    return vim.fn.has('win64') == 1 and 'wsl fish' or 'fish'
end

toggleterm.setup {
    direction = "float",
    shell = checkWin(),
    open_mapping = [[<C-t>]],
    shading_factor = 2,
    float_opts = {
      border = "curved",
      winblend = 10,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lg", hidden = true })

function _lazygit_toggle()
    lazygit:toggle()
end

keymap("n", "<leader>G", "<cmd>lua _lazygit_toggle()<CR>")
