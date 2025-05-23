return {
    root_markers = { "Cargo.toml", "cargo.toml" },
    settings = {
        ["rust-analyzer"] = {
            inlayHints = {
                typeHints = {
                    enable = true,
                },
                chainingHints = {
                    enable = true,
                },
                parameterHints = {
                    enable = true,
                },
            }
        }
    }
}
