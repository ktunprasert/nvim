return {
    capabilities = {
        textDocument = {
            formatting = false,
            rangeFormatting = false,
        }
    },

    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
