local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    virtual_text = false,
    -- disable virtual text
    -- virtual_text = {
    -- spacing = 100,
    -- virt_text_pos = "right_align",
    -- suffix = function(d)
    --     print(vim.inspect(d))
    --     -- repeat spaces
    --     --
    --     return "hi"
    -- end,
    -- },
    -- virtual_lines = true,
    -- show signs
    signs = false,
    -- signs = {
    --     active = signs,
    -- },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)
