local opts = {
    filetypes = { "html", "elixir", "eelixir", "heex", "eex", "svelte" },
    init_options = {
        userLanguages = {
            elixir = "html-eex",
            eelixir = "html-eex",
            heex = "html-eex",
            eex = "html-eex",
            svelte = "svelte",
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
