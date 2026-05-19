#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=./homebrew/Brewfile

# OhMyZsh
chsh -s /bin/zsh
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME"

# Starship
mkdir -p "$HOME/.config"
ln -sf "$HOME/.dotfiles/starship/starship.toml" "$HOME/.config"

# WezTerm
mkdir -p "$HOME/.config/wezterm/colors"
cd "$HOME/.config/wezterm/colors/"
curl -O https://raw.githubusercontent.com/dracula/wezterm/refs/heads/main/dracula.toml
ln -sf "$HOME/.dotfiles/wezterm/.wezterm.lua" "$HOME"

# git config
ln -sf "$HOME/.dotfiles/git/.gitconfig" "$HOME"

# Claude
mkdir -p "$HOME/.claude"
ln -sf "$HOME/.dotfiles/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$HOME/.dotfiles/claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$HOME/.dotfiles/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
# Skills and commands: dir symlinks so anything in the repo shows up in ~/.claude.
# Plugins themselves restore from settings.json (enabledPlugins + extraKnownMarketplaces) on first launch.
rm -rf "$HOME/.claude/skills" "$HOME/.claude/commands"
ln -sfn "$HOME/.dotfiles/claude/skills" "$HOME/.claude/skills"
ln -sfn "$HOME/.dotfiles/claude/commands" "$HOME/.claude/commands"

# GitHub Copilot
mkdir -p "$HOME/.github"
ln -sf "$HOME/.dotfiles/github/copilot-instructions.md" "$HOME/.github/copilot-instructions.md"
