#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=./homebrew/Brewfile

# Oh My Zsh
chsh -s /bin/zsh
ln -sf ~/.dotfiles/zsh/.zshrc $HOME
ln -sf ~/.dotfiles/zsh/.aliases.zsh $HOME

# Starship
mkdir -p ~/.config && ln -sf ~/.dotfiles/starship/starship.toml ~/.config

# Rosetta (Macs with M1 chip)
# Open a shell that's running using Rosetta: `arch -x86_64 zsh`
softwareupdate --install-rosetta
