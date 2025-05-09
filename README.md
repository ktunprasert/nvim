# Nvim-config

<!--toc:start-->
- [Nvim-config](#nvim-config)
  - [System dependencies](#system-dependencies)
    - [WSL Users](#wsl-users)
    - [Potential Manual Effort Required](#potential-manual-effort-required)
  - [Initial setup](#initial-setup)
    - [TreeSitter](#treesitter)
    - [LSP & Linters & Formatters & Dap](#lsp-linters-formatters-dap)
    - [~~Null-ls~~ None-ls](#null-ls-none-ls)
    - [Copilot](#copilot)
<!--toc:end-->

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
| [aichat](https://github.com/sigoden/aichat)          | For generating AI commits 😉                   |

Neovim version `0.11` and above is required

### WSL Users

| Name  | Why?                            |
| ----- | ------------------------------- |
| fzf   | Fuzzy search within fish        |
| wslu  | `xdg-open` from wsl to Windows  |
| omf-z | Basically `rupa-z` but for fish |
| xh    | `curl` for the 21st century     |

### Potential Manual Effort Required

- `lua/user/keymaps.lua`: resolve any keymap conflicts
- `lua/lsp/config`: configure the servers you want to use in `M.servers` table, this file is not tracked

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

### ~~Null-ls~~ None-ls

Use providers such as `prettier` to format JSON, YAML, TypeScript and JavaScript
files. Since `null-ls` is deprecated it's recommended to use `none-ls` instead [https://github.com/nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)

### Copilot

In order to use the Copilot AI autocompletion you must run the following command

```vim
:Copilot auth
```
