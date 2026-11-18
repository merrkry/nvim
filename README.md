# Neovim Config

See [`docs/vscode.md`](docs/vscode.md) for the VS Code Neovim profile and its
matching VS Code settings.

## Installation

Clone this repository as Neovim's config directory:

```sh
git clone https://github.com/merrkry/nvim ~/.config/nvim
```

On Windows, clone it to `%LOCALAPPDATA%\nvim` instead.

## Usage

Install from lockfile, useful when syncing configs:

```
nvim --headless "+Lazy! restore" +qa
```

Note that if plugins were added/removed, lockfile will be updated before the execution of this command.
You need to reset the lockfile and execute again.

Update without entering UI:

```
nvim --headless "+Lazy! sync" +qa
```

## Development

Run Neovim with a checkout as the config of the `nvim-dev` appname, which keeps
its plugins and state apart from the installed config:

```sh
mise run dev
mise run dev -- some-file
```

The task links `$XDG_CONFIG_HOME/nvim-dev` to the checkout and sets only
`NVIM_APPNAME`; it leaves the `XDG_*` variables inherited by LSP servers and
other child processes unchanged. Remove the data, cache, and state of an appname
explicitly:

```sh
mise run clean nvim-dev
```

`clean` removes a linked config, and keeps a config directory such as a clone.

Run `mise run update-plugins` to update the `nvim-dev` plugins and refresh
`lazy-lock.json` in the checkout.

## Local plugins

Keep editor settings in `lua/config/`. Implement repository-owned features in
`local/` and configure them through lazy.nvim specs in `lua/plugins/local.lua`.
