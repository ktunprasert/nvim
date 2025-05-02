local M = {}

do
    local prevbuf = nil -- Variable to store the previous buffer number

    -- Function to jump to the last visited buffer
    M.lastbuf = function()
        local current_buf = vim.fn.bufnr('%')
        -- Check if prevbuf is set, exists, is listed, and is not the current buffer
        if prevbuf and vim.fn.bufexists(prevbuf) == 1 and vim.fn.buflisted(prevbuf) == 1 and prevbuf ~= current_buf then
            vim.cmd.buffer(prevbuf)
            -- Optional: print("Switched to buffer " .. prevbuf)
        else
            vim.notify("No valid previous buffer to switch to.", vim.log.levels.WARN, { title = "Last Buffer" })
        end
    end

    -- Autocommand to track the last buffer
    local lastbuf_group = vim.api.nvim_create_augroup("LastBufTracking", { clear = true })
    vim.api.nvim_create_autocmd("BufLeave", {
        group = lastbuf_group,
        pattern = "*", -- Trigger for all buffers
        callback = function()
            local leaving_buf = vim.fn.bufnr('%')
            -- Ensure the buffer exists, is listed, and is a 'normal' buffer type
            -- before considering it as a potential previous buffer.
            if vim.fn.bufexists(leaving_buf) == 1 and vim.fn.buflisted(leaving_buf) == 1 and vim.bo[leaving_buf].buftype == '' and leaving_buf ~= prevbuf then
                -- vim.notify("Buffer " .. leaving_buf .. " is now the last visited buffer.", { title = "Last Buffer" },
                -- vim.log.levels.INFO)
                prevbuf = leaving_buf
            end
        end,
    })
end

-- Toggles cursor between column 0 and the first non-whitespace character
M.zero_or_first = function()
    local current_pos = vim.api.nvim_win_get_cursor(0) -- {row, col} (1-based row, 0-based col)
    local current_col = current_pos[2]

    if current_col == 0 then
        -- If already at column 0, go to the first non-whitespace character
        vim.schedule(function() vim.cmd('normal! ^') end)
    else
        -- Otherwise, go to column 0
        vim.schedule(function() vim.cmd('normal! 0') end)
    end
end

do
    local prevwin = nil -- Variable to store the previous window ID

    -- Autocommand to track the last window
    local lastwin_group = vim.api.nvim_create_augroup("LastWinTracking", { clear = true })
    vim.api.nvim_create_autocmd("WinLeave", {
        group = lastwin_group,
        pattern = "*", -- Trigger for all windows
        nested = true, -- Process nested events (e.g., leaving window triggers BufLeave)
        callback = function()
            local leaving_win = vim.fn.win_getid()
            -- Store the window ID if it's valid
            if vim.fn.win_getid() ~= 0 then
                -- Optional: Could add checks here to ignore floating windows, etc.
                local config = vim.api.nvim_win_get_config(leaving_win)
                if config.relative == '' and config.external == false then
                    -- vim.notify("Setting window " .. leaving_win .. " as the last visited window.",
                    --     { title = "Last Window" }, vim.log.levels.INFO)
                    prevwin = leaving_win
                end
            end
        end,
    })

    -- Function to jump to the last visited window
    M.lastwin = function()
        local current_win = vim.fn.win_getid()
        -- Check if prevwin is set, is still a valid window, and is not the current window
        if prevwin and vim.fn.win_getid() ~= 0 and prevwin ~= current_win then
            vim.fn.win_gotoid(prevwin)
        else
            vim.notify("No valid previous window to switch to.", vim.log.levels.WARN, { title = "Last Window" })
        end
    end
end

return M
