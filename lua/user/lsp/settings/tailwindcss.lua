local opts = {
    filetypes = { "html", "elixir", "eelixir", "heex", "eex" },
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
                    'class[:=]\\s*"([^"]*)"',
                },
            },
        },
    },
}

return opts
