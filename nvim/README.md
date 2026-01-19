# NeoVim Configuration

This configuration uses the following packages

### System
- neovim
- treesitter
- ripgrep

### Language Servers / Formatters
- [rust-analyzer](https://rust-lang.org/tools/install/)
- pyright
- black
- clangd
- gopls
- lua-language-server
- typescript-language-server
- eslint
- prettier
- terraform-ls
- yaml-language-server
- bash-language-server

### Debuggers
- debugpy
    ```
    mkdir -p $HOME/.virtualenvs
    cd $HOME/.virtualenvs
    python -m venv debugpy
    debugpy/bin/python -m pip install debugpy
    ```
- delve
- gdb
