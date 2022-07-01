local ok, session_lens = pcall(require, "session-lens")
if not ok then
    return
end

session_lens.setup {
    path_display = {"shorten"},
    previewer = false,
    theme_conf = {
        prompt_title = "Sessions",
    },
}

require('telescope').load_extension('session-lens')
