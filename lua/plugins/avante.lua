return {
    "yetone/avante.nvim",
    commit = "0b78b58760a5fd257797936e74e0bf5ddb445de1",
    cmd = { "AvanteToggle" },
    keys = {
        { "<leader>aT", "<Cmd>AvanteToggle<CR>", desc = "avante: toggle" },
    },
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = "copilot",
        behaviour = {
            auto_set_keymaps = true,
        },
        copilot = {
            endpoint = "https://api.githubcopilot.com",
            -- endpoint = "https://api.individual.githubcopilot.com",
            -- model = "gpt-4o-2024-08-06",
            -- available models
            -- "gpt-3.5-turbo" OK
            -- "gpt-3.5-turbo-0613" OK
            -- "gpt-4o-mini" OK
            -- "gpt-4o-mini-2024-07-18" OK
            -- "gpt-4" OK
            -- "gpt-4-0613" OK
            -- "gpt-4o" OK
            -- "gpt-4o-2024-05-13" OK
            -- "gpt-4-o-preview" OK
            -- "gpt-4o-2024-08-06" OK
            -- "gpt-4o-2024-11-20" OK
            -- "claude-3.5-sonnet" OK
            -- "claude-3.7-sonnet" OK
            -- "claude-3.7-sonnet-thought" OK
            -- "gemini-2.0-flash-001" OK
            --
            -- Untested
            -- "text-embedding-ada-002"
            -- "text-embedding-3-small"
            -- "text-embedding-3-small-inference"
            --
            -- Not OK
            -- The following are found in the API for the Immersive chat mode in GitHub copilot
            -- "o1" NOT OK
            -- "o1-2024-12-17" NOT OK
            -- "o3-mini" NOT OK
            -- "o3-mini-2025-01-31" NOT OK
            -- "o3-mini-paygo" NOT OK
            -- model = "claude-3.7-sonnet-thought",
            -- model = "claude-3.7-sonnet",
            model = "gemini-2.5-pro-preview-03-25",
        },
        windows = {
            wrap = true, -- similar to vim.o.wrap
            width = 30,  -- default % based on available width
            edit = { start_insert = false, },
            ask = {
                floating = false,     -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = false, -- Start insert mode when opening the ask window
            },
        },

    },
    build = "make",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
                debounce = 2000,
                overrides = {
                    buftype = {
                        nofile = {
                            code = { left_pad = 0, right_pad = 0 },
                        },
                    },
                },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
