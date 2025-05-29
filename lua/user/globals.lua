MASON_PATH = os.getenv("HOME") .. "/.local/share/nvim/mason/packages"
TRANSPARENT = false

_G.winblend = function()
    if TRANSPARENT then
        return 0
    end

    return 10
end

function _G._edit(fn, line_number)
    local edit_cmd = string.format(":e %s", fn)
    if line_number ~= nil then
        edit_cmd = string.format(":e +%d %s", line_number, fn)
    end
    vim.cmd(edit_cmd)
end

-- Space as <Leader>
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
