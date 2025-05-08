return {
    {
        "SmiteshP/nvim-navic",
        enabled = true,
        lazy = true,
        config = function()
            vim.g.navic_silence = true
            require("nvim-navic").setup({ highlight = true, depth_limit = 8 })
        end,
    },
    {
        "utilyre/barbecue.nvim",
        enabled = true,
        name = "barbecue",
        event = "LspAttach",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            show_dirname = false,
            show_basename = false,
        },
    },
    {
        enabled = false,
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        -- dependencies = {
        --     'nvim-telescope/telescope-fzf-native.nvim',
        --     build = 'make'
        -- },
        -- event = "LspAttach",
        config = function()
            require("dropbar").setup()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end
    }
}
