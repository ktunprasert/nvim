local function format()
    local null_ls_sources = require('null-ls.sources')
    local ft = vim.bo[0].filetype

    local has_null_ls = #null_ls_sources.get_available(ft, 'NULL_LS_FORMATTING') > 0

    vim.lsp.buf.format({
        filter = function(client)
            if has_null_ls then
                return client.name == 'null-ls'
            else
                return true
            end
        end,
        bufnr = 0,
        timeout_ms = 1000,
    })
end

vim.api.nvim_create_user_command("Format", format, {})

local autofmt_ft = {
    "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.json",
    "*.css", "*.scss", "*.html", "*.md", "*.yaml",
    "*.sh", "*.bash", "*.zsh", "*.fish", "*.dockerfile",
    "*.go", "*.ex", "*.exs", "*.elixir", "*.eex",
    "*.py",
}

vim.api.nvim_create_autocmd('LspAttach', {
    pattern = autofmt_ft,
    group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    if vim.v.cmdbang == 0 then
                        format()
                    end
                end,
            })
        end
    end,
})
