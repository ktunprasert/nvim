local ok, auto_session = pcall(require, "auto-session")
if not ok then
    return
end

auto_session.setup {
    log_level = 'info',
    pre_save_cmds = { "NeoTreeClose" },
    -- auto_session_enable_last_session = true,
}
