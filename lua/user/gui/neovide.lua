local keymap = require("lib.utils").keymap
local default_size = 11

vim.g.neovide_refresh_rate = 144

-- Lua documentation
-- https://www.ibm.com/docs/en/ias?topic=libraries-string-manipulation
-- https://www.ibm.com/docs/en/ias?topic=manipulation-stringgmatch-s-pattern
-- https://www.ibm.com/docs/en/ias?topic=manipulation-stringgsub-s-pattern-repl-n
_AdjustGUIFontSize = function(amount, exact)
    vim.opt.guifont = string.gsub(vim.opt.guifont._value, ":h(%d+)", function(n)
        local size = n + amount
        if exact ~= nil then
            size = amount
        end
        return string.format(":h%d", size)
    end)
end

keymap("n", "<A-Up>", function() _AdjustGUIFontSize(1) end)
keymap("n", "<A-Down>", function() _AdjustGUIFontSize(-1) end)
keymap("n", "<A-0>", function() _AdjustGUIFontSize(default_size, true) end)
