local cap_overrides = {
    workspace = {
        didChangeWatchedFiles = {
            dynamicRegistration = true,
            relativePatternSupport = true,
        },
    }
}

local cap = require('blink.cmp').get_lsp_capabilities(cap_overrides)

vim.lsp.config("*", {
    capabilities = cap,
    flags = {
        debounce_text_changes = 500,
    },
    -- root_dir = require("lspconfig").util.root_pattern('.git'),
    -- root_markers = require("lspconfig").util.root_pattern('.git'),
})

-- this is required so you dont have to download upstream changes...
require("lspconfig")

local servers = require("lsp.config") or require("lsp.config_example")

require("lsp.overrides")(servers)

-- PERF: potential for optimisation
-- by dynamically disabling servers
-- and allow certain servers during
-- bufenter
vim.lsp.enable(servers)
