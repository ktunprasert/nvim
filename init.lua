-- Global neovim dotfiles for configuring exactly your Neovim
--
-- User settings
vim.loader.enable()

require "user.globals"
require "user.options"
require "user.keymaps"
require "user.lazy"
require "user.abbreviations"
require "user.colors"

-- lsp related
require "lsp"
