return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
        { mode = { "n", "x" }, "ga", },
        { mode = "x",          "zs", },
        { mode = "n",          "gV", },
        { mode = { "n", "x" }, "<C-up>", },
        { mode = { "n", "x" }, "<C-down>", },
        { mode = { "n", "x" }, "<leader>k", },
        { mode = { "n", "x" }, "<leader>j", },
        { mode = { "n", "x" }, "<C-n>", },
        { mode = { "n", "x" }, "<leader>M", },
        { mode = "n",          "<leader>/", },
        { mode = "n",          "<c-leftmouse>", },
        { mode = "n",          "<c-leftdrag>", },
        { mode = "n",          "<c-leftrelease>", },
        { mode = { "n", "x" }, "<c-q>", },
        { mode = { "n", "x" }, "<leader>|", },
        -- { mode = { "n", "x" }, "<leader><leader>]d", },
        -- { mode = { "n", "x" }, "<leader><leader>[d", },
        -- { mode = { "n", "x" }, "<leader><leader>m", },
        -- { mode = { "n", "x" }, "<leader><leader>M", },
    },
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        local set = vim.keymap.set

        -- for expressions
        -- e.g. ga3j, gaR
        set({ "n", "x" }, "ga", mc.addCursorOperator, { desc = "[MULTC] Operator" })
        -- set({ "n", "x" }, "<leader><leader>m", mc.addCursorOperator, { desc = "[MULTC] Operator" })

        -- Split visual selections by regex.
        set("x", "zs", mc.splitCursors, { desc = "[MULTC] Split Regex" })

        -- bring back cursors if you accidentally clear them
        set("n", "gV", mc.restoreCursors, { desc = "[MULTC] Restore Cursors" })

        -- Add or skip cursor above/below the main cursor.
        set({ "n", "x" }, "<C-up>", function() mc.lineAddCursor(-1) end, { desc = "[MULTC] Add Cursor Up" })
        set({ "n", "x" }, "<C-down>", function() mc.lineAddCursor(1) end, { desc = "[MULTC] Add Cursor Down" })
        set({ "n", "x" }, "<leader>k", function() mc.lineSkipCursor(-1) end, { desc = "[MULTC] Skip Up" })
        set({ "n", "x" }, "<leader>j", function() mc.lineSkipCursor(1) end, { desc = "[MULTC] Skip Down" })

        -- Add or skip adding a new cursor by matching word/selection
        set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "[MULTC] Next Match" })

        -- Add a cursor for all matches of cursor word/selection in the document.
        -- set({ "n", "x" }, "<leader><leader>M", mc.matchAllAddCursors, { desc = "[MULTC] All Matches" })
        set({ "n", "x" }, "<leader>M", mc.matchAllAddCursors, { desc = "[MULTC] All Matches" })

        -- Pressing `<leader>miwap` will create a cursor in every match of the
        -- string captured by `iw` inside range `ap`.
        -- This action is highly customizable, see `:h multicursor-operator`.
        set({ "n", "x" }, "<leader>|", mc.operator, { desc = "[MULTC] Operator in Range" })

        -- Add a cursor to every search result in the buffer.
        set("n", "<leader>/", mc.searchAllAddCursors, { desc = "[MULTC] All Search Matches" })

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse, { desc = "[MULTC] Mouse" })
        set("n", "<c-leftdrag>", mc.handleMouseDrag, { desc = "[MULTC] Drag" })
        set("n", "<c-leftrelease>", mc.handleMouseRelease, { desc = "[MULTC] Drag OK" })

        -- Disable and enable cursors.
        set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "[MULTC] Manual" })

        -- Add or skip adding a new cursor by matching diagnostics.
        -- set({ "n", "x" },
        --     "<leader><leader>]d",
        --     function() mc.diagnosticAddCursor(1) end,
        --     { desc = "[MULTC] Next Diagnostic" })
        -- set({ "n", "x" },
        --     "<leader><leader>[d",
        --     function() mc.diagnosticAddCursor(-1) end,
        --     { desc = "[MULTC] Prev Diagnostic" })

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- skip cursor
            layerSet({ "n", "x" }, "Q", function() mc.matchSkipCursor(-1) end, { desc = "[MULTC] Skip Prev" })
            layerSet({ "n", "x" }, "q", function() mc.matchSkipCursor(1) end, { desc = "[MULTC] Skip Next" })

            -- Select a different cursor as the main one.
            layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "[MULTC] Prev" })
            layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "[MULTC] Next" })

            -- Delete the main cursor.
            layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "[MULTC] Delete Cursor" })
            layerSet({ "n", "x" }, "<BS>", mc.deleteCursor, { desc = "[MULTC] Delete Cursor" })

            -- Enter to confirm C-Q selection
            layerSet("n", "<CR>", mc.enableCursors, { desc = "[MULTC] Confirm" })
            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", mc.clearCursors, { desc = "[MULTC] Clear" })
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end
}
