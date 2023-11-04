# Nvim-config

<a href="https://dotfyle.com/ktunprasert/nvim-config"><img src="https://dotfyle.com/ktunprasert/nvim-config/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/ktunprasert/nvim-config"><img src="https://dotfyle.com/ktunprasert/nvim-config/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/ktunprasert/nvim-config"><img src="https://dotfyle.com/ktunprasert/nvim-config/badges/plugin-manager?style=flat" /></a>

## System dependencies

The following requirements are required for running the configuration distro

| Name                                                 | Why?                                           |
| ---------------------------------------------------- | ---------------------------------------------- |
| git                                                  | Plugins management                             |
| npm                                                  | Installing formatters as providers for null-ls |
| [rg](https://github.com/BurntSushi/ripgrep)          | Live text search within the project            |
| [fd](https://github.com/sharkdp/fd)                  | File searching with Telescope                  |
| [lazygit](https://github.com/jesseduffield/lazygit/) | Managing Git repositories                      |
| [delta](https://github.com/dandavison/delta)         | Git diff within LazyGit                        |

Neovim version `0.8` and above is required

### Potential Manual Effort Required

- `lua/user/lsp/null-ls.lua` disable binding for missing binary (eg. prettier)
- `lua/user/plugins/toggleterm.lua`: define alternative shell if not using `fish`
- `lua/user/keymaps.lua`: resolve any keymap conflicts

## Initial setup

### TreeSitter

Install syntax highlighter for any language you will be using with

```vim
:TSInstall python
:TSInstall php
:TSInstall go
```

or visit [treesitter](https://github.com/nvim-treesitter/nvim-treesitter/) for
more information

### LSP & Linters & Formatters & Dap

Install the language server for the languages you will be using

```vim
:Mason
```

or visit [mason](https://github.com/williamboman/mason-lspconfig.nvim) for
more information

Sources installed via Mason will be available through Null-ls as well
for example installing python's black formatter then setting up a null-ls source

### Null-ls

Use providers such as `prettier` to format JSON, YAML, TypeScript and JavaScript
files. See more information at [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim/)

### Copilot

In order to use the Copilot AI autocompletion you must run the following command

```vim
:Copilot auth
```

Follow the instructions

