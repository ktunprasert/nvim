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
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

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
    },
    wintype = {
        function()
            if vim.bo.buftype ~= "" then
                return " " .. vim.bo.buftype
            end

            return ""
        end
    },
    cwd = {
        function()
            local cwd = vim.fn.getcwd(0)
            if cwd == "" then
                return ""
            end

            return cwd:gsub(".*/", "")
        end,
    },
    searchcount = {
        "searchcount",
        color = 'AshenG3',
    },
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { 'kyazdani42/nvim-web-devicons', opt = true },
        { 'ficcdaf/ashen.nvim' },
        { 'rmagatti/auto-session' },
    },
    opts = {
        options = {
            icons_enabled = true,
            -- component_separators = { left = '|', right = '|' },
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            globalstatus = true,
            always_divide_middle = false,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                components.cwd,
                "branch",
                {
                    "filename",
                    path = 1,
                    shorting_target = 20,
                },
            },
            lualine_c = { "diff" },
            lualine_x = { components.searchcount, components.diagnostics },
            lualine_y = { "fileformat", components.lsp, "filetype", components.wintype },
            lualine_z = { "os.date('%H:%M')" },
        },
        extensions = {
            "toggleterm",
        }
    },
    config = function(cfg)
        local ashen_opts = require("ashen.plugins.lualine").lualine_opts
        ashen_opts.extensions = { "lazy", "fzf" }
        require("lualine").setup(vim.tbl_deep_extend("force", ashen_opts, cfg.opts))
    end
}
