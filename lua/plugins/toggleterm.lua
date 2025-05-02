-- local keymap = require('lib.utils').keymap
-- local cmd = require("lib.utils").cmdcr
-- function checkWin()
--     return vim.fn.has('win64') == 1 and 'bash' or 'fish'
-- end

function _G._edit(fn, line_number)
    local edit_cmd = string.format(":e %s", fn)
    if line_number ~= nil then
        edit_cmd = string.format(":e +%d %s", line_number, fn)
    end
    vim.cmd(edit_cmd)
end

return {
    "akinsho/toggleterm.nvim",
    keys = {
        { "<Leader>G" }
    },
    version = '*',
    opts = {
        direction = "float",
        shell = 'fish',
        open_mapping = [[<C-t>]],
        shading_factor = 2,
        float_opts = {
            border = "curved",
            winblend = winblend(),
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    },
    config = function(cfg)
        require("toggleterm").setup(cfg.opts)
        local Terminal = require('toggleterm.terminal').Terminal

        do
            local lazygit
            -- For Editing back from LazyGit
            function _G.Lazygit_toggle()
                -- local git_root_cmd = "git rev-parse --show-toplevel"
                -- local lg_cmd = string.format("lg -p $(%s)", git_root_cmd)
                local lg_cmd = "lg"
                if vim.v.servername ~= nil then
                    local config_path = vim.fn.stdpath('config'):gsub('\\', '/')
                    lg_cmd = string.format(
                        'lg -ucf "%s/lazygit.yml,%s/lg_ashen.yaml"',
                        config_path,
                        config_path
                    )
                end

                if lazygit ~= nil then
                    vim.notify("cache hit")
                else
                    vim.notify("cache miss")
                    lazygit = Terminal:new({
                        shell = 'fish',
                        count = 5,
                        cmd = lg_cmd,
                        env = {
                            NVIM_DIR = vim.fn.stdpath('config'),
                        },
                    })
                end

                lazygit:toggle()
            end
        end

        vim.keymap.set("n", "<Leader>G", function() _G.Lazygit_toggle() end, { desc = "Lazygit" })
    end
}
