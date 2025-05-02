vim.opt_local.shiftwidth = 4

local function organize_imports_async()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
end

vim.keymap.set('n', '<F6>', organize_imports_async, { desc = 'Organize Import', buffer = true })
