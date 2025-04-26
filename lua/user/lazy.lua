local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local lazyOpts = {
    install = {
        colorscheme = { "ashen" },
    }
}

require("lazy").setup({
    require("user.lazy.setup"),
    require("user.lazy.themes"),
    require("user.lazy.lsp"),
    require("user.lazy.telescope"),
    require("user.lazy.util"),
    require("user.lazy.navigation"),
    require("user.lazy.ui"),
    -- Own Plugins
    {
        "ktunprasert/gui-font-resize.nvim",
        enabled = vim.g.neovide or false,
        config = true,
    },
}, lazyOpts)
