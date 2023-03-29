local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local h = require("null-ls.helpers")
local FMT = require("null-ls.methods").internal.FORMATTING

null_ls.setup({
    debug = false,
    sources = {
        -- TODO: Add Binaries so we can perform Formatting and Diagnostics
        formatting.prettier.with({ extra_args = {} }),
        formatting.black.with({ extra_args = { "--fast" } }),
        -- formatting.blue.with({ extra_args = { "--fast" } }),
        -- formatting.yamlfmt.with({ extra_args = { "-conf=~/.config/.yamlfmt" } }),
        -- formatting.stylua,
        -- diagnostics.flake8
        -- null_ls.builtins.code_actions.gitsigns,
        h.make_builtin(
            {
                name = "v fmt",
                method = FMT,
                filetypes = { "v" },
                generator_opts = {
                    command = "v",
                    args = { "fmt" },
                    to_stdin = true,
                },
                factory = h.formatter_factory,
            }
        ),
    },
})
