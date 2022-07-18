local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
    return
end

local keymap = require('lib.utils').keymap

function checkWin()
    return vim.fn.has('win64') == 1 and 'bash' or 'fish'
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

local lg_cmd = "lg $(pwd)"
if vim.v.servername ~= nil then
    local config_path = vim.fn.stdpath('config'):gsub('\\','/')
    lg_cmd = string.format('NVIM_SERVER=%s lg -ucf %s/lazygit.toml -p $(pwd)', vim.v.servername, config_path)
end

local lazygit = Terminal:new({
    count = 5,
    cmd = lg_cmd,
})

-- For Editing back from LazyGit
function _edit(fn, line_number)
    local edit_cmd = string.format(":e %s", fn)
    if line_number ~= nil then
        edit_cmd = string.format(":e +%d %s", line_number, fn)
    end
    vim.cmd(edit_cmd)
end

function _lazygit_toggle()
    lazygit:toggle()
end

keymap("n", "<leader>G", "<cmd>lua _lazygit_toggle()<CR>")
