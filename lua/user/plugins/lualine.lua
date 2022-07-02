local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

local components = {
    diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
    },
    treesitter = {
        function()
            local b = vim.api.nvim_get_current_buf()
            if next(vim.treesitter.highlighter.active[b]) then
                return ""
            end
            return ""
        end,
        -- color = { fg = green },
    },
    lsp = {
        function(msg)
            msg = msg or "LS Inactive"
            local buf_clients = vim.lsp.buf_get_clients()
            if next(buf_clients) == nil then
                -- TODO: clean up this if statement
                if type(msg) == "boolean" or #msg == 0 then
                    return "LS Inactive"
                end
                return msg
            end
            local buf_ft = vim.bo.filetype
            local buf_client_names = {}

            -- add client
            for _, client in pairs(buf_clients) do
                if client.name ~= "null-ls" then
                    table.insert(buf_client_names, client.name)
                end
            end

            -- add formatter
            local formatters = require "lvim.lsp.null-ls.formatters"
            local supported_formatters = formatters.list_registered(buf_ft)
            vim.list_extend(buf_client_names, supported_formatters)

            -- add linter
            local linters = require "lvim.lsp.null-ls.linters"
            local supported_linters = linters.list_registered(buf_ft)
            vim.list_extend(buf_client_names, supported_linters)

            local unique_client_names = vim.fn.uniq(buf_client_names)
            return "[" .. table.concat(unique_client_names, ", ") .. "]"
        end,
        color = { gui = "bold" },
    },
    encoding = {
        "o:encoding",
        fmt = string.upper,
        color = {},
    },
    filetype = {
        "filetype",
        fmt = string.upper
    }
}

lualine.setup {
    options = {
        icons_enabled = true,
        component_separators = { left = '|', right = '|' },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "filename", "diff" },
        lualine_c = { components.diagnostics, components.treesitter, components.lsp },
        lualine_x = {},
        lualine_y = { components.encoding, components.filetype, "progress" },
        lualine_z = { "location", "tabs" },
    },
    extensions = {
        "nvim-tree",
        "toggleterm",
    }
}
