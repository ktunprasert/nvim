local bufferline = require("bufferline")

bufferline.setup {
    options = {
        numbers = "buffer_id",
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "id",
    }
}