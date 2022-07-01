local auto_session = require("auto-session")

auto_session.setup {
    log_level = 'info',
    auto_session_suppress_dirs = {'~/'}
}

