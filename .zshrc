# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git brew docker)

# Skip compinit's insecure-directory audit (compaudit); safe on a single-user Mac
# and shaves the completion-init cost off every startup.
ZSH_DISABLE_COMPFIX="true"

[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# --- cached command-substitution helper -------------------------------------
# Memoizes a command's stdout to a file, refreshing only when the cache is
# missing or older than 7 days. Keeps startup fast while staying correct across
# tool upgrades (node/java/etc.). Bust manually: rm -rf ~/.cache/zsh-init
_cache_cmd() {
  local key="$1"; shift
  local cache="$HOME/.cache/zsh-init/$key"
  if [[ ! -s "$cache" || -n "$(find "$cache" -mtime +7 2>/dev/null)" ]]; then
    mkdir -p "${cache:h}"
    "$@" >| "$cache" 2>/dev/null
  fi
  cat "$cache"
}

command -v fzf >/dev/null && source <(_cache_cmd fzf-init fzf --zsh)

alias vi="nvim"
alias vim="nvim"

gitr() { find -H . -name .git -type d -execdir pwd \; -execdir git "$@" \; -exec printf "\n" \; }
command -v go >/dev/null && export PATH="$PATH:$(_cache_cmd gopath go env GOPATH)/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# brew github token — set lazily on first `brew` call instead of every startup
brew() {
  unset -f brew
  export HOMEBREW_GITHUB_API_TOKEN="$(command gh auth token 2>/dev/null)"
  command brew "$@"
}

# OpenJDK 21 (Homebrew)
if [[ -d "/opt/homebrew/opt/openjdk@21/bin" ]]; then
  export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
  export JAVA_HOME="$(_cache_cmd javahome-21 /usr/libexec/java_home -v 21)"
fi

command -v npm >/dev/null && export PATH="$(_cache_cmd npm-prefix npm config get prefix)/bin:$PATH"

# rbenv: put shims on PATH directly (instant) so ruby/gem work; defer the
# heavier `rbenv init` shell integration until rbenv is actually invoked.
if [[ -d "$HOME/.rbenv" ]]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  rbenv() {
    unset -f rbenv
    eval "$(command rbenv init - zsh)"
    rbenv "$@"
  }
fi

# LM Studio CLI (lms)
[[ -d "$HOME/.lmstudio/bin" ]] && export PATH="$PATH:$HOME/.lmstudio/bin"

[[ -r "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# git-ai
if [[ -d "$HOME/.git-ai/bin" ]]; then
  export NODE_USE_SYSTEM_CA=1
  export PATH="$HOME/.git-ai/bin:$PATH"
fi

# Homebrew-managed zsh plugins. Sourced here rather than via Oh My Zsh's
# plugins=(...) array, which only discovers plugins under $ZSH_CUSTOM/plugins.
# zsh-syntax-highlighting must be sourced last.
HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
[[ -r "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
  && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -r "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
  && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
