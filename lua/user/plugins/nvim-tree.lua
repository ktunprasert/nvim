local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end


nvim_tree.setup {
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                { key = "<C-e>", action = "close" },
                { key = "<A-l>", action = "vsplit" },
                { key = "<A-j>", action = "split" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
}
