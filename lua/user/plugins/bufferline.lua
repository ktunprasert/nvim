local ok, bufferline = pcall(require, "bufferline")
if not ok then
    return
end

bufferline.setup {
    options = {
        numbers = function(opts)
            return string.format('%s{%s}', opts.raise(opts.ordinal), opts.id)
        end,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "id",
    }
}
