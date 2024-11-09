export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export LANG=en_US.UTF-8
export EDITOR="code -w"

plugins=(
    git
    npm
    brew
    command-not-found
    zsh-autosuggestions
)

export HOMEBREW_NO_ENV_HINTS=false
eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

PATH=~/.console-ninja/.bin:$PATH

[ -f $HOME/.aliases.zsh ] && source $HOME/.aliases.zsh
[ -f $HOME/.private.zsh ] && source $HOME/.private.zsh