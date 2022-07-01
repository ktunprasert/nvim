local session_lens = require("session-lens")

session_lens.setup {
    path_display = {"shorten"},
    previewer = false,
    theme_conf = {
        prompt_title = "Sessions",
    },
}

require('telescope').load_extension('session-lens')
