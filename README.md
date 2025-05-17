# Dotfiles for macOS

This repository includes configuration for:

- [Homebrew](https://brew.sh/) - Package manager for macOS
- [OhMyZsh](https://ohmyz.sh/) - Framework for managing Zsh configuration
- [Starship](https://starship.rs/) - Minimal, blazing-fast, and infinitely customizable prompt for any shell
- [WezTerm](https://wezterm.org/) - GPU-accelerated cross-platform terminal emulator and multiplexer
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

## Configuration Details

### Homebrew

The `Brewfile` in the `homebrew/` directory contains all the packages, casks, and apps that will be installed.

### Zsh

The dotfiles include:

- `.zshrc` - Main Zsh configuration file
- `.private.zsh` - Private configuration (not tracked in git)

### Starship

The prompt is configured via `starship.toml` which is symlinked to `~/.config/starship.toml`.

### WezTerm

Terminal configuration in `.wezterm.lua` includes:

- [Dracula theme](https://draculatheme.com/) installation
- Custom key mappings and configuration

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

### Git Aliases

The installation script sets up git aliases:

- `push-fwl` - Push with --force-with-lease flag
- `ss` - Status with short format
