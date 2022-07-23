-- :help options
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.completeopt = { "menuone", "noselect" } -- for cmp
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.smartcase = true
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
vim.opt.signcolumn = "no"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true
vim.cmd [[set guifont=Iosevka:h11]]
vim.opt.tm = 500 -- for faster WhichKey toggle
vim.opt.autochdir = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.cmd([[ au WinLeave * set nocursorline nocursorcolumn ]])
vim.cmd([[ au WinEnter * set cursorline cursorcolumn ]])
vim.opt.shortmess:append "c"
vim.opt.relativenumber = true

-- For auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

if os.getenv('SHELL') == "C:\\Program Files\\Git\\usr\\bin\\bash.exe" then
    print("Windows Git Bash Found - setting shell compatibility")
    vim.cmd [[let &shellcmdflag = '-c']]
    vim.cmd [[set shellxquote="]]
end

-- For Neovide
if vim.g.neovide then
    require("user.gui.neovide")
end
