local ok, tsconfigs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

local ensure = {
    "lua", "json",
    "javascript", "python", "dockerfile", "bash",
    -- "php", "phpdoc"
    "go", "gomod",
}

tsconfigs.setup {
    ensure_installed = ensure,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    }
}
