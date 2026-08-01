#!/usr/bin/env bash
#
# install.sh — symlink the dotfiles in this repo into $HOME.
#
# Usage:
#   ./install.sh            # symlink dotfiles
#   ./install.sh --brew     # also run `brew bundle` first
#
# Existing files are backed up to <file>.bak before being replaced.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Map of "source (relative to repo)" -> "destination (relative to $HOME)".
FILES=(
  ".zshrc:.zshrc"
  ".config/starship.toml:.config/starship.toml"
)

log() { printf '\033[1;32m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33mwarn:\033[0m %s\n' "$1"; }

link_file() {
  local src="$REPO_DIR/$1"
  local dest="$HOME/$2"

  if [[ ! -e "$src" ]]; then
    warn "source missing, skipping: $src"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  # Already pointing at the repo file — nothing to do (idempotent).
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    log "up to date: ~/$2"
    return
  fi

  # Back up an existing real file or differing symlink.
  if [[ -e "$dest" || -L "$dest" ]]; then
    warn "backing up ~/$2 -> ~/$2.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -s "$src" "$dest"
  log "linked ~/$2 -> $src"
}

main() {
  if [[ "${1:-}" == "--brew" ]]; then
    if command -v brew >/dev/null; then
      log "running brew bundle"
      brew bundle --file="$REPO_DIR/Brewfile"
    else
      warn "Homebrew not found; skipping brew bundle. See https://brew.sh"
    fi
  fi

  for entry in "${FILES[@]}"; do
    link_file "${entry%%:*}" "${entry##*:}"
  done

  log "Done. Open a new shell or run: exec zsh"
}

main "$@"
