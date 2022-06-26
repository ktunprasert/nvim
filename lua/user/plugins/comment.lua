local comment = require('Comment')

comment.setup {
    -- ignores empty lines
    ignore = "^$",

    mappings = {
        basic = true,
        extra = false,
    },
}
