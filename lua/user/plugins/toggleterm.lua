local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
    return
end

local keymap = require('lib.utils').keymap
local cmd = require("lib.utils").cmdcr

-- function checkWin()
--     return vim.fn.has('win64') == 1 and 'bash' or 'fish'
-- end

toggleterm.setup {
    direction = "float",
    shell = 'fish',
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

-- For Editing back from LazyGit
function _G._edit(fn, line_number)
    local edit_cmd = string.format(":e %s", fn)
    if line_number ~= nil then
        edit_cmd = string.format(":e +%d %s", line_number, fn)
    end
    vim.cmd(edit_cmd)
end

function Lazygit_toggle()
    local git_root_cmd = "git rev-parse --show-toplevel"
    local lg_cmd = string.format("lg -p $(%s)", git_root_cmd)
    if vim.v.servername ~= nil then
        local config_path = vim.fn.stdpath('config'):gsub('\\', '/')
        lg_cmd = string.format(
            'lg -ucf "%s/lazygit.yml,%s/lg_ashen.yaml" -p $(%s)',
            config_path,
            config_path,
            git_root_cmd
        )
    end

    local lazygit = Terminal:new({
        shell = 'fish',
        count = 5,
        cmd = lg_cmd,
        env = {
            NVIM_DIR = vim.fn.stdpath('config'),
        },
    })
    lazygit:toggle()
end

keymap("n", "<leader>G", cmd("lua Lazygit_toggle()"))

keymap("n", "<Leader>t", cmd("ToggleTerm"))
keymap("n", "1<Leader>t", cmd("ToggleTerm 1"))
keymap("n", "2<Leader>t", cmd("ToggleTerm 2"))
keymap("n", "3<Leader>t", cmd("ToggleTerm 3"))
keymap("n", "4<Leader>t", cmd("ToggleTerm 4"))
