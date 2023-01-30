local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

local components = {
    diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        component_separators = { left = '', right = '' },
    },
    lsp = {
        function(msg)
            msg = msg or ""
            local buf_clients = vim.lsp.buf_get_clients()
            if next(buf_clients) == nil then
                if type(msg) == "boolean" or #msg == 0 then
                    return ""
                end
                return msg
            end
            local buf_ft = vim.bo.filetype
            local buf_client_names = {}

            for _, client in pairs(buf_clients) do
                if client.name ~= "null-ls" then
                    table.insert(buf_client_names, client.name)
                end
            end

            local unique_client_names = vim.fn.uniq(buf_client_names)
            return table.concat(unique_client_names, "|")
        end,
    },
    encoding = {
        "o:encoding",
        fmt = string.upper,
        color = {},
    },
    filetype = {
        "filetype",
        colored = false,
        fmt = string.upper
    }
}

local function is_git_repo()
    local is_repo = vim.fn.system('git rev-parse --is-inside-worktree')
    return vim.v.shell_error == 0
end

lualine.setup {
    options = {
        icons_enabled = true,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            require('auto-session-library').current_session_name,
            "branch",
            {
                "filename",
                path = 1,
            },
        },
        lualine_c = { "diff" },
        lualine_x = { components.diagnostics },
        lualine_y = { "fileformat", components.lsp, components.filetype },
        lualine_z = { "progress", "os.date('%H:%M')" },
    },
    extensions = {
        -- "nvim-tree",
        "toggleterm",
    }
}
