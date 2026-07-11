zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew docker zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

source <(fzf --zsh)

alias vi="nvim"
alias vim="nvim"

gitr() { find -H . -name .git -type d -execdir pwd \; -execdir git "$@" \; -exec printf "\n" \; }

export PATH=$PATH:$(go env GOPATH)/bin

# pnpm
export PNPM_HOME="/Users/rahil.shaikh/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# brew github token
export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$(npm config get prefix)/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/rahil.shaikh/.lmstudio/bin"
# End of LM Studio CLI section

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
