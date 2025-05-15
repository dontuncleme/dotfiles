#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=./homebrew/Brewfile

# OhMyZsh
chsh -s /bin/zsh
ln -sf $HOME/.dotfiles/zsh/.zshrc $HOME

# Starship
mkdir -p $HOME/.config
ln -sf $HOME/.dotfiles/starship/starship.toml $HOME/.config

# WezTerm
mkdir -p $HOME/.config/wezterm/colors
cd $HOME/.config/wezterm/colors/
curl -O https://raw.githubusercontent.com/dracula/wezterm/refs/heads/main/dracula.toml

# git config
git config --global alias.push-fwl "push --force-with-lease"

# GitHub Copilot
mkdir -p $HOME/.github
ln -sf $HOME/.dotfiles/github/copilot-instructions.md $HOME/.github/copilot-instructions.md

ln -sf $HOME/.dotfiles/wezterm/.wezterm.lua $HOME
