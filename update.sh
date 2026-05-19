#!/bin/bash

# Homebrew
if command -v brew >/dev/null 2>&1; then
    brew update
    brew upgrade
    brew bundle --file=./homebrew/Brewfile
    brew cleanup
fi

# OhMyZsh
if [ -f "$HOME/.dotfiles/zsh/.zshrc" ]; then
    ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME"
fi

# Starship
if command -v starship >/dev/null 2>&1; then
    mkdir -p "$HOME/.config"
    ln -sf "$HOME/.dotfiles/starship/starship.toml" "$HOME/.config"
fi

# WezTerm
if command -v wezterm >/dev/null 2>&1; then
    mkdir -p "$HOME/.config/wezterm/colors"
    ln -sf "$HOME/.dotfiles/wezterm/.wezterm.lua" "$HOME"
fi

# Update Dracula theme for WezTerm
cd "$HOME/.config/wezterm/colors/"
curl -O https://raw.githubusercontent.com/dracula/wezterm/refs/heads/main/dracula.toml
cd - > /dev/null

# git config
if [ -f "$HOME/.dotfiles/git/.gitconfig" ]; then
    ln -sf "$HOME/.dotfiles/git/.gitconfig" "$HOME"
fi

# GitHub Copilot
if [ -f "$HOME/.dotfiles/github/copilot-instructions.md" ]; then
    mkdir -p "$HOME/.github"
    ln -sf "$HOME/.dotfiles/github/copilot-instructions.md" "$HOME/.github/copilot-instructions.md"
fi

# Claude
if [ -f "$HOME/.dotfiles/claude/CLAUDE.md" ]; then
    mkdir -p "$HOME/.claude"
    ln -sf "$HOME/.dotfiles/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
    ln -sf "$HOME/.dotfiles/claude/settings.json" "$HOME/.claude/settings.json"
    ln -sf "$HOME/.dotfiles/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
    rm -rf "$HOME/.claude/skills" "$HOME/.claude/commands"
    ln -sfn "$HOME/.dotfiles/claude/skills" "$HOME/.claude/skills"
    ln -sfn "$HOME/.dotfiles/claude/commands" "$HOME/.claude/commands"
fi

# Update dotfiles repository
git pull origin $(git rev-parse --abbrev-ref HEAD)
