local opts = {
    root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern("tailwind.config.cjs")(fname)
    end
}

return opts
