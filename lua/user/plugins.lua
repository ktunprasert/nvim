local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)

    -- ███████╗███████╗████████╗██╗   ██╗██████╗
    -- ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
    -- ███████╗█████╗     ██║   ██║   ██║██████╔╝
    -- ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝
    -- ███████║███████╗   ██║   ╚██████╔╝██║
    -- ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ~ Setup
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
    use { "lewis6991/impatient.nvim", config = function() require("impatient") end }

    -- ████████╗██╗  ██╗███████╗███╗   ███╗███████╗███████╗
    -- ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝██╔════╝
    --    ██║   ███████║█████╗  ██╔████╔██║█████╗  ███████╗
    --    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝  ╚════██║
    --    ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗███████║
    --    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝╚══════╝ ~ Themes
    use {
        "ellisonleao/gruvbox.nvim",
        config = function() require("gruvbox").setup { contrast = "hard" } end,
        commit = 'cb7a8a867cfaa7f0e8ded57eb931da88635e7007',
    }
    use { "tiagovla/tokyodark.nvim" }
    use "rebelot/kanagawa.nvim"
    use {
        "yashguptaz/calvera-dark.nvim",
        config = function() require("user.themes.calvera") end
    }

    -- ██╗     ███████╗██████╗     ██████╗███╗   ███╗██████╗
    -- ██║     ██╔════╝██╔══██╗   ██╔════╝████╗ ████║██╔══██╗
    -- ██║     ███████╗██████╔╝   ██║     ██╔████╔██║██████╔╝
    -- ██║     ╚════██║██╔═══╝    ██║     ██║╚██╔╝██║██╔═══╝
    -- ███████╗███████║██║███████╗╚██████╗██║ ╚═╝ ██║██║
    -- ╚══════╝╚══════╝╚═╝╚══════╝ ╚═════╝╚═╝     ╚═╝╚═╝     ~ LSP and Autocompletion
    -- CMP dependencies
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use { 'tzachar/cmp-tabnine', run = './install.sh' }

    -- Snippets engine
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple LSP installer - just werks
    use "nvim-telescope/telescope-ui-select.nvim"
    use { "ray-x/lsp_signature.nvim", config = function() require("user.lsp.lsp_signature") end }

    -- Linter/Formatter
    use {
        "jose-elias-alvarez/null-ls.nvim", -- for formatters and linter
        config = function() require("user.lsp.null-ls") end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function() require("user.plugins.treesitter") end,
        run = ":TSUpdate",
    }
    use {
        config = function() require("user.plugins.symbols-outline").setup() end,
        "simrat39/symbols-outline.nvim",
    }

    -- ████████╗███████╗██╗     ███████╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
    -- ╚══██╔══╝██╔════╝██║     ██╔════╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
    --    ██║   █████╗  ██║     █████╗  ███████╗██║     ██║   ██║██████╔╝█████╗
    --    ██║   ██╔══╝  ██║     ██╔══╝  ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝
    --    ██║   ███████╗███████╗███████╗███████║╚██████╗╚██████╔╝██║     ███████╗
    --    ╚═╝   ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝ ~ Telescope
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    }
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-telescope/telescope-live-grep-raw.nvim' },
        },
        config = function() require("user.plugins.telescope") end
    }

    -- ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗
    -- ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝
    -- ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝
    -- ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║
    --  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝   ~ Utility
    use "tpope/vim-surround"
    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("user.plugins.gitsigns") end
    }
    use {
        "folke/which-key.nvim",
        config = function() require("user.plugins.whichkey") end
    }
    use {
        "numToStr/Comment.nvim",
        config = function() require("user.plugins.comment") end
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require("user.plugins.lualine") end
    }
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function() require("user.plugins.toggleterm") end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function() require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
        } end
    }
    use {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("user.plugins.bufferline") end
    }
    -- use {
    --     'kyazdani42/nvim-tree.lua',
    --     requires = {
    --         'kyazdani42/nvim-web-devicons', -- optional, for file icons
    --     },
    --     tag = 'nightly', -- optional, updated every week. (see issue #1193)
    --     config = function() require("user.plugins.nvim-tree") end
    -- }
    use {
        'rmagatti/auto-session',
        config = function() require("user.plugins.sessions.auto-session") end
    }
    use {
        'rmagatti/session-lens',
        requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        config = function() require("user.plugins.sessions.session-lens") end
    }
    use {
        "ahmedkhalf/project.nvim",
        config = function() require("user.plugins.project") end
    }
    use { "windwp/nvim-autopairs", config = function() require("user.plugins.autopairs") end }
    use { "folke/zen-mode.nvim", config = function() require("zen-mode").setup({
            window = {
                width = 150,
                options = {
                    wrap = true,
                }
            }
        })
    end }
    use { "xiyaowong/nvim-transparent", config = function() require("transparent").setup({ enable = not vim.g.neovide }) end }
    use { "jinh0/eyeliner.nvim", config = function() require("user.plugins.eyeliner") end }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            {
                's1n7ax/nvim-window-picker',
                tag = "v1.*",
                config = function()
                    require 'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        selection_chars = 'ABCDEFGHIJK',
                        filter_rules = {
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal' },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        },
        config = function() require("user.plugins.neotree") end,
    }

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
        config = function()
            vim.g.navic_silence = true
            require("nvim-navic").setup {
                icons = {
                    File          = " ",
                    Module        = " ",
                    Namespace     = " ",
                    Package       = " ",
                    Class         = " ",
                    Method        = " ",
                    Property      = " ",
                    Field         = " ",
                    Constructor   = " ",
                    Enum          = "練",
                    Interface     = "練",
                    Function      = " ",
                    Variable      = " ",
                    Constant      = " ",
                    String        = " ",
                    Number        = " ",
                    Boolean       = "◩ ",
                    Array         = " ",
                    Object        = " ",
                    Key           = " ",
                    Null          = "ﳠ ",
                    EnumMember    = " ",
                    Struct        = " ",
                    Event         = " ",
                    Operator      = " ",
                    TypeParameter = " ",
                },
                highlight = false,
                separator = " > ",
                depth_limit = 0,
                depth_limit_indicator = "..",
                safe_output = true
            }
            vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end,
    }
    -- ███╗   ██╗ █████╗ ██╗   ██╗██╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
    -- ████╗  ██║██╔══██╗██║   ██║██║██╔════╝ ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
    -- ██╔██╗ ██║███████║██║   ██║██║██║  ███╗███████║   ██║   ██║██║   ██║██╔██╗ ██║
    -- ██║╚██╗██║██╔══██║╚██╗ ██╔╝██║██║   ██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
    -- ██║ ╚████║██║  ██║ ╚████╔╝ ██║╚██████╔╝██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
    -- ╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ~ Navigation
    use {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function() require("user.plugins.hop") end
    }
    use {
        "chaoren/vim-wordmotion",
        config = function() require("user.plugins.wordmotion") end
    }

    -- Own Plugins
    use {
        "ktunprasert/gui-font-resize.nvim",
        config = function() require("gui-font-resize").setup() end
    }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
