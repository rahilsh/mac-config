# mac-config

Personal macOS dotfiles and shell configuration. A small, opinionated setup for
a Zsh + Oh My Zsh + Starship development environment on macOS (Apple Silicon).

## Contents

| File | Description |
| --- | --- |
| `.zshrc` | Zsh configuration: Oh My Zsh, plugins, history, aliases, and PATH/env setup for common dev tools. |
| `.config/starship.toml` | [Starship](https://starship.rs) prompt configuration. |
| `.gitignore` | Ignores macOS cruft (e.g. `.DS_Store`). |

## Features

- **Shell**: [Zsh](https://www.zsh.org) with [Oh My Zsh](https://ohmyz.sh) (`robbyrussell` theme).
- **Prompt**: [Starship](https://starship.rs) cross-shell prompt.
- **Plugins**: `git`, `brew`, `docker`, [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting), [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions).
- **Fuzzy finding**: [`fzf`](https://github.com/junegunn/fzf) key bindings and completion.
- **Editor aliases**: `vi`/`vim` mapped to [Neovim](https://neovim.io).
- **Version managers**: [`mise`](https://mise.jdx.dev), [`nvm`](https://github.com/nvm-sh/nvm), [`rbenv`](https://github.com/rbenv/rbenv).
- **Toolchains on PATH**: Go, Node/npm, [pnpm](https://pnpm.io), OpenJDK 21, MySQL client, [LM Studio](https://lmstudio.ai) CLI.

## Prerequisites

Install these before applying the config:

```sh
# Homebrew (https://brew.sh)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tools
brew install zsh fzf neovim starship mise nvm rbenv pnpm go openjdk@21 mysql-client

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
```

## Installation

Clone the repo and symlink (or copy) the files into your home directory. Back up
your existing config first.

```sh
git clone https://github.com/rahilsh/mac-config.git
cd mac-config

# Back up existing files
cp ~/.zshrc ~/.zshrc.bak 2>/dev/null || true

# Symlink into place
ln -sf "$PWD/.zshrc" ~/.zshrc
mkdir -p ~/.config
ln -sf "$PWD/.config/starship.toml" ~/.config/starship.toml

# Reload
exec zsh
```

> **Note:** `.zshrc` contains a few machine-specific absolute paths (e.g.
> `/Users/rahil.shaikh/...` for `pnpm` and LM Studio). Update these to match your
> own username/home directory after cloning.

## License

Licensed under the [Apache License 2.0](LICENSE).
