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
            local buf_clients = vim.lsp.get_clients({
                bufnr = vim.api.nvim_get_current_buf(),
            })

            if #buf_clients == 0 then
                return ""
            end

            if next(buf_clients) == nil then
                if type(msg) == "boolean" or #msg == 0 then
                    return ""
                end

                return msg
            end

            return vim.iter(buf_clients)
                :filter(function(client) return client.name ~= "null-ls" end)
                :map(function(client) return client.name end)
                :join("")
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
        -- fmt = string.upper
    },
    wintype = {
        function()
            if vim.bo.buftype ~= "" then
                return " " .. vim.bo.buftype
            end

            return ""
        end
    }
}

local function is_git_repo()
    local is_repo = vim.fn.system('git rev-parse --is-inside-worktree')
    return vim.v.shell_error == 0
end

local opts = {
    options = {
        icons_enabled = true,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            require('auto-session.lib').current_session_name,
            "branch",
            {
                "filename",
                path = 1,
            },
        },
        lualine_c = { "diff" },
        lualine_x = { components.diagnostics },
        lualine_y = { "fileformat", components.lsp, components.filetype, components.wintype },
        lualine_z = { "progress", "os.date('%H:%M')" },
    },
    extensions = {
        -- "nvim-tree",
        "toggleterm",
    }
}

local ashen_opts = require("ashen.plugins.lualine").lualine_opts
lualine.setup(vim.tbl_deep_extend("force", ashen_opts, opts))
