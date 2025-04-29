local cap_overrides = {
    workspace = {
        didChangeWatchedFiles = {
            dynamicRegistration = true,
            relativePatternSupport = true,
        },
    }
}

vim.lsp.config("*", {
    flags = {
        debounce_text_changes = 500,
    },
    -- root_dir = require("lspconfig").util.root_pattern('.git'),
    -- root_markers = require("lspconfig").util.root_pattern('.git'),
})

-- this is required so you dont have to download upstream changes...
require("lspconfig")

local servers = require("lsp.config") or require("lsp.config_example")

-- PERF: potential for optimisation
-- by dynamically disabling servers
-- and allow certain servers during
-- bufenter
vim.lsp.enable(servers)
