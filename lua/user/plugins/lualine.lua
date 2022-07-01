local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end


lualine.setup {
    options = {
        icons_enabled = true,
        component_separators = { left = '|', right = '|' },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename", "diff" },
        lualine_x = {},
        lualine_y = { "encoding", "filetype","progress" },
        lualine_z = { "location", "tabs" },
    },
}
