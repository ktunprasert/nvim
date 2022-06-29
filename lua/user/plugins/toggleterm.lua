local toggleterm = require "toggleterm"

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
