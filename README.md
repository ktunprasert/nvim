# Nvim-config

## System dependencies

The following requirements are required for running the configuration distro

| Name                                                 | Why?                                           |
| ---------------------------------------------------- | ---------------------------------------------- |
| git                                                  | Plugins management                             |
| npm                                                  | Installing formatters as providers for null-ls |
| [rg](https://github.com/jesseduffield/lazygit/)      | Live text search within the project            |
| [fd](https://github.com/sharkdp/fd)                  | File searching with Telescope                  |
| [lazygit](https://github.com/jesseduffield/lazygit/) | Managing Git repositories                      |

Neovim version `0.8` and above is required

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

### LSP

Install the language server for the languages you will be using

```vim
:LspInstall gopls
:LspInstall intelephense
" or interactively
:LspInstallInfo
```

or visit [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for
more information

### TabNine

In order to use the TabNine AI autocompletion you must run the following command

```vim
:CmpTabNineHub
```

This will automatically open a TabNine configuration page in your browser which
will require authentication

### Null-ls

Use providers such as `prettier` to format JSON, YAML, TypeScript and JavaScript
files. See more information at [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim/)
