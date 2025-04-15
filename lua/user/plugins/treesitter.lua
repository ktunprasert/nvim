local ok, tsconfigs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

local ensure = {
    "lua", "json",
    "javascript", "python", "dockerfile", "bash",
    "php", "phpdoc",
    "go", "gomod",
}

tsconfigs.setup {
    ensure_installed = ensure,
    highlight = {
        enable = false,
    },
    indent = {
        enable = true
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["gab"] = "@block.outer",
                ["gib"] = "@block.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V',  -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]f"] = "@function.outer",
                ["]b"] = "@block.outer",
                ["]t"] = "@conditional.outer",
                ["]?"] = "@comment.outer",
                ["]l"] = "@variable",
                ["]]"] = { query = "@class.outer", desc = "Next class start" },
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]F"] = "@function.outer",
                ["]B"] = "@block.outer",
                ["]T"] = "@conditional.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[f"] = "@function.outer",
                ["[t"] = "@conditional.outer",
                ["[b"] = "@block.outer",
                ["[?"] = "@comment.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[F"] = "@function.outer",
                ["[B"] = "@block.outer",
                ["[]"] = "@class.outer",
            },
        },
    }
}

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local current_bufnr = vim.api.nvim_get_current_buf()
        local file_path = vim.api.nvim_buf_get_name(current_bufnr)
        if file_path ~= "" then
            local file_size = vim.fn.getfsize(file_path)
            local max_size_bytes = 1024 * 1000 -- Example: 1MB
            if file_size > max_size_bytes then
                -- ts_highlight.disable(current_bufnr)
                vim.cmd("TSBufDisable " .. current_bufnr .. "")
                vim.notify("Tree-sitter highlighting disabled for this large file.", vim.log.levels.WARN)
            else
                vim.cmd("TSBufEnable " .. current_bufnr .. "")
                -- ts_highlight.enable(current_bufnr) -- Ensure it's enabled if it was disabled globally
            end
        end
    end
})
