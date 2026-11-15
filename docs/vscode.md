# VS Code mode

VS Code and VS Code Neovim handle:

- Insert-mode input
- Comments
- Completion and language support
- Editor UI, indentation, folding, and highlighting

Neovim handles Normal and Visual mode editing.
Treesitter parsers stay enabled for text objects and motions.

## Setup

Use `asvetliakov.vscode-neovim` instead of `vscodevim.vim`.

Here are some VS Code that might need to be manually synced.

```jsonc
"extensions.experimental.affinity": {
    "asvetliakov.vscode-neovim": 1
},
"vscode-neovim.compositeKeys": {
    "jk": {
        "command": "vscode-neovim.escape"
    }
},
"vscode-neovim.compositeTimeout": 100
```
