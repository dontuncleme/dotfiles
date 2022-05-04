export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export LANG=en_US.UTF-8
export EDITOR="code -w"

ZSH_THEME="robbyrussell"
plugins=(git npm brew command-not-found macos zsh-autosuggestions)

# Aliases
if [ -f ~/.aliases.zsh ]; then
    . ~/.aliases.zsh
fi

# Private
if [ -f ~/.private.zsh ]; then
    . ~/.private.zsh
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
