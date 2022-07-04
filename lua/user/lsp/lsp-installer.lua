local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
    return
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    if server.name == "jsonls" then
        local jsonls_opts = require("user.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server.name == "yamlls" then
        local yamlls_opts = require("user.lsp.settings.yamlls")
        opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    if server.name == "sumneko_lua" then
        local sumneko_opts = require("user.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "intelephense" then
        local intelephense = require("user.lsp.settings.intelephense")
        opts = vim.tbl_deep_extend("force", intelephense, opts)
    end

    server:setup(opts)
end)
