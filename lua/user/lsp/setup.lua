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
};

for _, s in pairs(servers) do
    local ok, server_opts = pcall(require, "user.lsp.settings."..s)
    if ok then
        server_opts = vim.tbl_deep_extend("force", server_opts, opts)
    else
        server_opts = opts
    end
    require("lspconfig")[s].setup(server_opts)
end
