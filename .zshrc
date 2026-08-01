# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git brew docker zsh-autosuggestions zsh-syntax-highlighting)

# Skip compinit's insecure-directory audit (compaudit); safe on a single-user Mac
# and shaves the completion-init cost off every startup.
ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

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

source <(_cache_cmd fzf-init fzf --zsh)

alias vi="nvim"
alias vim="nvim"

gitr() { find -H . -name .git -type d -execdir pwd \; -execdir git "$@" \; -exec printf "\n" \; }
export PATH="$PATH:$(_cache_cmd gopath go env GOPATH)/bin"

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

export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export JAVA_HOME="$(_cache_cmd javahome-21 /usr/libexec/java_home -v 21)"
export PATH="$(_cache_cmd npm-prefix npm config get prefix)/bin:$PATH"

# rbenv: put shims on PATH directly (instant) so ruby/gem work; defer the
# heavier `rbenv init` shell integration until rbenv is actually invoked.
export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
rbenv() {
  unset -f rbenv
  eval "$(command rbenv init - zsh)"
  rbenv "$@"
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

. "$HOME/.local/bin/env"

# Added by git-ai installer
export NODE_USE_SYSTEM_CA=1
export PATH="$HOME/.git-ai/bin:$PATH"
