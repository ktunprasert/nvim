local opts = {
    root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern("tailwind.config.cjs")(fname)
    end,
    filetypes = { "html", "elixir", "eelixir", "heex" },
    init_options = {
        userLanguages = {
            elixir = "html-eex",
            eelixir = "html-eex",
            heex = "html-eex",
        },
    },
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    'class[:]\\s*"([^"]*)"',
                },
            },
        },
    },
}

return opts
