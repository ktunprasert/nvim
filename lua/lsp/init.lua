require("lsp.setup")

for _, value in pairs({
    "lsp.null-ls",
    "lsp.diagnostics",
    "lsp.format",
}) do
    vim.schedule(function() require(value) end)
end
