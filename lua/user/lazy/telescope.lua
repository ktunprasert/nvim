return {
    -- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
    -- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
    --    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
    --    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
    --    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
    --    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝ ~ Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-telescope/telescope-live-grep-raw.nvim' },
        },
        config = function() require("user.plugins.telescope") end
    },
    { "nvim-telescope/telescope-hop.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = false },
}
