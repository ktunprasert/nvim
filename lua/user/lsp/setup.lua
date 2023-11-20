local on_attach = require("user.lsp.handlers").on_attach
local capabilities = require("user.lsp.handlers").capabilities


local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local servers = {
    "bashls",
    "cssls",
    "emmet_ls",
    "eslint",
    "gopls",
    "html",
    "intelephense",
    "jdtls",
    "jsonls",
    "lua_ls",
    "marksman",
    "pyright",
    "svelte",
    "tsserver",
    "yamlls",
    "zk",
    "tailwindcss",
    "elixirls",
};

for _, s in pairs(servers) do
    local ok, server_opts = pcall(require, "user.lsp.settings." .. s)
    if ok then
        server_opts = vim.tbl_deep_extend("force", server_opts, opts)
    else
        server_opts = opts
    end
    require("lspconfig")[s].setup(server_opts)
end

local function format()
    local null_ls_sources = require('null-ls.sources')
    local ft = vim.bo[0].filetype

    local has_null_ls = #null_ls_sources.get_available(ft, 'NULL_LS_FORMATTING') > 0

    vim.lsp.buf.format({
        bufnr = 0,
        filter = function(client)
            if has_null_ls then
                return client.name == 'null-ls'
            else
                return true
            end
        end,
    })
end

vim.api.nvim_create_user_command("Format", function() format() end, {})
