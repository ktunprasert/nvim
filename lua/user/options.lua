-- :help options
vim.opt.backup = false
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.completeopt = { "menuone", "noselect" } -- for cmp
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.pumheight = 30
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300 -- faster completion
vim.opt.hidden = true
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "auto:1"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true
-- vim.opt.guifont = "Iosevka:h12,Iosevka_Nerd_Font:h12,Garuda:h12"
vim.opt.guifont = "Iosvmata:h12"
vim.opt.guifontwide = "Garuda:h12"
vim.opt.tm = 500 -- for faster WhichKey toggle
vim.opt.autochdir = false
vim.opt.shortmess:append "c"
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.laststatus = 3

vim.go.lazyredraw = true

-- check for windows
if vim.fn.has("win32") ~= 1 then
    vim.opt.fileformat = "unix"
    -- vim.api.nvim_create_augroup("ConvertToLF", { clear = true })
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = "ConvertToLF",
    --     pattern = "*",
    --     callback = function()
    --
    --     end,
    -- })
end


-- For auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

if os.getenv('SHELL') == "C:\\Program Files\\Git\\usr\\bin\\bash.exe" then
    print("Windows Git Bash Found - setting shell compatibility")
    vim.cmd [[let &shellcmdflag = '-c']]
    vim.cmd [[set shellxquote="]]
end

-- For Neovide
if vim.g.neovide then
    require("user.gui.neovide")
end

-- local is_wsl = (
--     function() local output = vim.fn.systemlist "uname -r" return not not string.find(output[1] or "", "WSL") end
--     )()

-- if is_wsl then
--     vim.cmd [[
--       augroup Yank
--       autocmd!
--       autocmd TextYankPost * :call system('/c/windows/system32/clip.exe ',@")
--       augroup END
--     ]]
-- end

-- Turn off relative number when in command mode, but exclude special buffer types
vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- Define excluded filetypes
local excluded_filetypes = {
    ["toggleterm"] = true,
    ["avanteinput"] = true,
    ["avanteselectedfiles"] = true,
    ["avante"] = true,
    ["neo-tree"] = true,
}

local excluded_buftypes = {
    ["nofile"] = true,
    ["prompt"] = true,
    ["quickfix"] = true,
    ["help"] = true,
    ["terminal"] = true,
}

vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = "numbertoggle",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local buftype = vim.bo[buf].buftype
        local filetype = vim.bo[buf].filetype

        -- Skip for excluded buffer types
        if excluded_buftypes[buftype] or excluded_filetypes[filetype] then
            return
        end

        vim.opt.relativenumber = false
        vim.cmd("redraw")
    end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = "numbertoggle",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local buftype = vim.bo[buf].buftype
        local filetype = vim.bo[buf].filetype

        -- Skip for excluded buffer types
        if excluded_buftypes[buftype] or excluded_filetypes[filetype] then
            return
        end

        vim.opt.relativenumber = true
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- automatically remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function(_)
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.cmd([[%s/\r$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- ensure filetype is set for help buffers
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function(args)
        if vim.bo[args.buf].buftype == "help" then
            vim.bo[args.buf].filetype = "help"
        end
    end,
})
