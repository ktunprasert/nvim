require("lsp.setup")

vim.iter({ "lsp.diagnostics", "lsp.format" }):each(function(value)
    vim.schedule(function() require(value) end)
end)
