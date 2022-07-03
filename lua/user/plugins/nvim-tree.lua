local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end


nvim_tree.setup {
    sort_by = "case_sensitive",
    view = {
        side = "right",
        hide_root_folder = false,
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
        add_trailing = true,
        group_empty = true,
        icons = {
            git_placement = "before",
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "",
                },
            },
        },
    },
    filters = {
        dotfiles = true,
    },
    update_focused_file = {
        enable = true,
        update_root = false,
    },
}
