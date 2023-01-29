return {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
                diagnosticSeverityOverrides = {
                    reportGeneralTypeIssues = "warning",
                }
            }
        }
    },
    root_dir = require("lspconfig").util.root_pattern('.git'),
}
