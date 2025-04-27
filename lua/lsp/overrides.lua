local cfgs = {
    taplo = {
        settings = {
            include = { ".config/**/*.toml" },
        },
    },
}

return function(servers)
    for _, server in pairs(servers) do
        local opts = cfgs[server]
        if opts ~= nil then
            vim.lsp.config(server, opts)
        end
    end
end
