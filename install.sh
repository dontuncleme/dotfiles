#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=./homebrew/Brewfile

# Oh My Zsh
chsh -s /bin/zsh
ln -sf $HOME/.dotfiles/zsh/.zshrc $HOME
ln -sf $HOME/.dotfiles/zsh/.aliases.zsh $HOME

# Config
mkdir -p $HOME/.config
ln -sf $HOME/.dotfiles/starship/starship.toml $HOME/.config

# Rosetta (Macs with M1 chip)
# Open a shell that's running using Rosetta: `arch -x86_64 zsh`
softwareupdate --install-rosetta
