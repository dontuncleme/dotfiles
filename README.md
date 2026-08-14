# Dotfiles for macOS

This repository includes configuration for:

- [Homebrew](https://brew.sh/) - Package manager for macOS
- [zinit](https://github.com/zdharma-continuum/zinit) - Flexible Zsh plugin manager (loads OhMyZsh snippets)
- [Starship](https://starship.rs/) - Minimal, blazing-fast, and infinitely customizable prompt for any shell
- [WezTerm](https://wezterm.org/) - GPU-accelerated cross-platform terminal emulator and multiplexer
- [Claude Code](https://code.claude.com/docs) - Anthropic's CLI for Claude

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

- `.zshrc` - Main Zsh configuration. Uses [zinit](https://github.com/zdharma-continuum/zinit) for plugins and OhMyZsh (OMZL/OMZP) snippets
- `.private.zsh` - Private configuration (not tracked in git, template in `.private.zsh.default`)

### Starship

The prompt is configured via `starship.toml` which is symlinked to `~/.config/starship.toml`.

### WezTerm

Terminal configuration in `.wezterm.lua` includes:

- [Dracula theme](https://draculatheme.com/) installation
- Custom key mappings and configuration

### Git Configuration

The `install.sh` script symlinks `git/.gitconfig` to `~/.gitconfig`. This file holds shared, non-sensitive Git config and includes a local, per-machine file for identity.

Identity (name, email, signing key) is never committed. Three gitignored files hold it, each with a `.default` template:

- `git/config-local.inc` has the `includeIf` rules mapping folders to an identity. Repeat a block per folder, and the last match wins.
- `git/config-personal.inc` and `git/config-work.inc` hold the `[user]` and signing config each rule points to.

On a fresh machine, copy each template and fill it in:

```bash
cp git/config-local.inc.default    git/config-local.inc     # edit folder rules
cp git/config-personal.inc.default git/config-personal.inc   # edit identity
cp git/config-work.inc.default     git/config-work.inc
```

#### [1Password signing and auth keys](https://www.1password.dev/ssh/get-started)

Both commit signing and SSH auth run through keys kept in 1Password. Turn on its SSH agent under Settings > Developer > "Use the SSH agent", and add your terminal to the authorized apps. Then point SSH at the agent in `~/.ssh/config`:

```text
Host *
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

The agent hands SSH every key it holds, so a work repo can end up authenticating as your personal key, whichever one GitHub accepts first. To avoid that, each identity file pins a single key with `core.sshCommand` (`IdentitiesOnly=yes -i <pubkey>`). Public keys aren't secret, but the files do have to exist on disk. Pull them out of 1Password with `ssh-add -L`:

```bash
ssh-add -L | grep 'GitHub Personal$' > ~/.ssh/github-personal.pub
ssh-add -L | grep 'GitHub Work$' > ~/.ssh/github-work.pub
```

The first `git fetch` in a folder pops a 1Password approval (Touch ID). Approve it once and the key stays authorized for the session.

There's a catch with the green Verified badge. GitHub keeps auth keys and signing keys separate, so you have to add the same public key a second time, this time as a Signing Key (Settings > SSH and GPG keys > New SSH key, then pick Key type: Signing Key). Skip that and every commit shows up as Unverified, even though it's signed. Grab a key with:

```bash
pbcopy < ~/.ssh/github-personal.pub
```

### Claude Code

- `CLAUDE.md` - global instructions, symlinked to `~/.claude/CLAUDE.md`
- `settings.json` - model, enabled plugins, marketplace sources, statusline config
- `statusline-command.sh` - custom status bar showing model, rate limits, context %
- `skills/`, `commands/` - directory symlinks so repo skills/commands show up in `~/.claude`

On a fresh machine, plugins listed in `settings.json` may need manual install via `claude plugins install <name>` if Claude Code doesn't auto-install them.
