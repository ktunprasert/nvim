local M = {}

M.on_attach = function(client, bufnr)
    if client.name == "ts_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.server_capabilities.documentSymbolProvider then
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
end

local capabilities_override = {
    workspace = {
        didChangeWatchedFiles = {
            dynamicRegistration = true,
            relativePatternSupport = true,
        },
    }
}

M.capabilities = require('blink.cmp').get_lsp_capabilities(capabilities_override)

return M
