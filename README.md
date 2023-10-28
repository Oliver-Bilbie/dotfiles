# NeoVim Configuration

This is my own custom NeoVim configuration built using [jdhao's configuration](https://github.com/jdhao/nvim-config) as a foundation.
I would strongly advise against using this configuration yourself, because:
- It is likely to change significantly and suddenly based purely on what I fancy trying out.
- Building your own nvim config is a great learning experience, and will give you a deeper understanding and appreciation for your editor.

## Requirements
### Pacman / Homebrew
- neovim
- clangd
- terraform-ls
- lua-language-server
- lldb
- delve
- ripgrep

### Pip
- pynvim
- python-lsp-server[all]
- pylsp-mypy
- python-lsp-isort
- python-lsp-black
- debugpy
    ```
    mkdir .virtualenvs
    cd .virtualenvs
    python -m venv debugpy
    debugpy/bin/python -m pip install debugpy
    ```
- pylint
- mypy
- black

### NPM
- typescript-language-server
- yaml-language-server
- bash-language-server
- vim-language-server
- eslint
- prettier

### Manual
- rust-analyzer
- [vscode-eslint](https://github.com/microsoft/vscode-eslint)
- [vscode-js-debug](https://github.com/mxsdev/nvim-dap-vscode-js)
