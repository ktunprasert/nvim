local ok, comment = pcall(require, "Comment")
if not ok then
    return
end


comment.setup {
    -- ignores empty lines
    ignore = "^$",

    mappings = {
        basic = true,
        extra = false,
    },

    toggler = {
        line = "<Leader>c",
    },
}
