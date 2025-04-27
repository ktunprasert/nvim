return {
    settings = {
        python = {
            analysis = {
                reportUnusedVariable = "none",
                typeCheckingMode = "off",
                diagnosticSeverityOverrides = {
                    reportGeneralTypeIssues = "warning",
                }
            }
        }
    },
    root_dir = require("lspconfig").util.root_pattern('.git'),
}
