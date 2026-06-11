# Dotfiles for macOS

This repository includes configuration for:

- [Homebrew](https://brew.sh/) - Package manager for macOS
- [zinit](https://github.com/zdharma-continuum/zinit) - Flexible Zsh plugin manager (loads OhMyZsh snippets)
- [Starship](https://starship.rs/) - Minimal, blazing-fast, and infinitely customizable prompt for any shell
- [WezTerm](https://wezterm.org/) - GPU-accelerated cross-platform terminal emulator and multiplexer
- [Claude Code](https://code.claude.com/docs) - Anthropic's CLI for Claude
- [GitHub Copilot](https://github.com/features/copilot) - AI pair programming tool

## Installation

Clone the repository:

```bash
git clone https://github.com/dontuncleme/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
```

Run the installation script:

```bash
./install.sh
```

## Updating

To update all managed tools, configs, and symlinks after initial install, use:

```bash
./update.sh
```

## Configuration Details

### Homebrew

The `Brewfile` in the `homebrew/` directory contains all the packages, casks, and apps that will be installed.

### Zsh

The dotfiles include:

- `.zshrc` - Main Zsh configuration; uses [zinit](https://github.com/zdharma-continuum/zinit) for plugins and OhMyZsh (OMZL/OMZP) snippets
- `.private.zsh` - Private configuration (not tracked in git; template in `.private.zsh.default`)

### Starship

The prompt is configured via `starship.toml` which is symlinked to `~/.config/starship.toml`.

### WezTerm

Terminal configuration in `.wezterm.lua` includes:

- [Dracula theme](https://draculatheme.com/) installation
- Custom key mappings and configuration

### Git Configuration

The `install.sh` script symlinks `git/.gitconfig` to `~/.gitconfig`. This file contains global Git configurations.

### Claude Code

- `CLAUDE.md` — global instructions, symlinked to `~/.claude/CLAUDE.md`
- `settings.json` — model, enabled plugins, marketplace sources, statusline config
- `statusline-command.sh` — custom status bar showing model, rate limits, context %
- `skills/`, `commands/` — directory symlinks so repo skills/commands show up in `~/.claude`

On a fresh machine, plugins listed in `settings.json` may need manual install via `claude plugins install <name>` if Claude Code doesn't auto-install them.

### GitHub Copilot

Contains [custom instructions](https://github.com/x1xhlol/system-prompts-and-models-of-ai-tools) for GitHub Copilot in `github/copilot-instructions.md`.

To set up GitHub Copilot with these configurations, add the following to your VS Code `settings.json`:

```json
{
  "chat.instructionsFilesLocations": {
    "~/.github/copilot-instructions.md": true
  }
}
```
