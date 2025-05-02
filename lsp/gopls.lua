return {
    capabilities = {
        workspace = {
            didCreateFiles = true,
        },
    },
    settings = {
        gopls = {
            buildFlags = { "-tags=mine" },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    }
}
