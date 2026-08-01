# mac-config

Personal macOS dotfiles and shell configuration — an opinionated, startup-optimized
Zsh + Oh My Zsh + Starship setup for Apple Silicon Macs.

## Contents

| Path | Description |
| --- | --- |
| `.zshrc` | Zsh configuration: Oh My Zsh, plugins, history, aliases, and lazy-loaded tool setup. |
| `.config/starship.toml` | [Starship](https://starship.rs) prompt configuration. |
| `.config/alacritty/alacritty.toml` | [Alacritty](https://alacritty.org) terminal configuration. |
| `Brewfile` | Homebrew dependencies (`brew bundle`). |
| `install.sh` | Symlinks the dotfiles into `$HOME` (with backups). |

## Features

- **Shell**: [Zsh](https://www.zsh.org) with [Oh My Zsh](https://ohmyz.sh) (`robbyrussell` theme).
- **Terminal**: [Alacritty](https://alacritty.org) with iTerm2-style keybindings and tmux split shortcuts.
- **Prompt**: [Starship](https://starship.rs).
- **Plugins**: `git`, `brew`, `docker`, [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting), [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions).
- **Fuzzy finding**: [`fzf`](https://github.com/junegunn/fzf) key bindings and completion.
- **Editor**: `vi`/`vim` aliased to [Neovim](https://neovim.io).
- **Languages / managers**: Go, Node (npm), [pnpm](https://pnpm.io), [rbenv](https://github.com/rbenv/rbenv), OpenJDK 21.

### Startup performance

The `.zshrc` is tuned for fast shell startup:

- `_cache_cmd` memoizes slow command substitutions (e.g. `go env GOPATH`,
  `java_home`, `npm config get prefix`) to `~/.cache/zsh-init`, refreshing weekly.
- `brew`, `rbenv`, and other integrations are **lazy-loaded** — their heavy
  init runs only on first use, not on every shell.
- `ZSH_DISABLE_COMPFIX="true"` skips the completion-security audit on a
  single-user Mac.
- Every tool hook is guarded by an availability check, so the config loads
  cleanly even when a tool isn't installed.

## Installation

```sh
git clone https://github.com/rahilsh/mac-config.git
cd mac-config

# Install dependencies (optional) and symlink the dotfiles.
# Existing files are backed up to <file>.bak.
./install.sh --brew

# Reload
exec zsh
```

Run `./install.sh` without `--brew` to only symlink the dotfiles, or
`brew bundle` on its own to just install the Homebrew dependencies.

### Manual dependencies

A few things Homebrew doesn't manage:

```sh
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). This repo follows
[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) and lints
shell scripts with [ShellCheck](https://www.shellcheck.net) in CI.

## License

Licensed under the [Apache License 2.0](LICENSE). See [NOTICE](NOTICE).
