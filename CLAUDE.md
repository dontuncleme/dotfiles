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
| `claude/skills/` | (dir) | `~/.claude/skills/` |
| `claude/commands/` | (dir) | `~/.claude/commands/` |
| `claude/rules/` | (dir) | `~/.claude/rules/` |
| `github/` | `copilot-instructions.md` | `~/.github/` |

## Key details

- `zsh/.private.zsh` is gitignored — private env vars/secrets go there (`.private.zsh.default` is the template)
- Git identity is gitignored: `.gitconfig` unconditionally includes `git/config-local.inc` (per-folder `includeIf` rules), which points to `git/config-personal.inc` / `git/config-work.inc`. Each has a `.default` template to copy and fill on a new machine
- Zsh plugin manager is zinit (not OhMyZsh directly), but loads OMZL/OMZP snippets
- WezTerm uses Dracula theme downloaded at install time (not vendored)
- Claude plugins restore from `settings.json` (`enabledPlugins` + `extraKnownMarketplaces`) on first launch — not vendored
- Main branch: `trunk`
