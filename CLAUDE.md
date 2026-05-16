# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS dotfiles repo. Configs for Homebrew, Zsh (zinit + OhMyZsh snippets), Starship prompt, WezTerm terminal, Git, Claude, and GitHub Copilot. All managed via symlinks.

## Commands

- `./install.sh` — first-time setup: installs Homebrew, packages, creates all symlinks
- `./update.sh` — updates Homebrew packages, refreshes symlinks, pulls latest dotfiles

## Structure

Each tool gets its own directory with config files that get symlinked to their expected locations:

| Directory | Config file | Symlink target |
| --- | --- | --- |
| `homebrew/` | `Brewfile` | used in-place by `brew bundle` |
| `zsh/` | `.zshrc` | `~/` |
| `starship/` | `starship.toml` | `~/.config/` |
| `wezterm/` | `.wezterm.lua` | `~/` |
| `git/` | `.gitconfig` | `~/` |
| `claude/` | `CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `claude/` | `settings.json` | `~/.claude/settings.json` |
| `claude/` | `statusline-command.sh` | `~/.claude/statusline-command.sh` |
| `github/` | `copilot-instructions.md` | `~/.github/` |

## Key details

- `zsh/.private.zsh` is gitignored — private env vars/secrets go there (`.private.zsh.default` is the template)
- Zsh plugin manager is zinit (not OhMyZsh directly), but loads OMZL/OMZP snippets
- WezTerm uses Dracula theme downloaded at install time (not vendored)
- Main branch: `trunk`
