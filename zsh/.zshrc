# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# 1Password SSH agent
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light junegunn/fzf-git.sh

# snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::gh
zinit snippet OMZP::npm
zinit snippet OMZP::brew
zinit snippet OMZP::command-not-found

# load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# aliases
alias o="open"
alias oo="open ."
alias ls='ls --color'
alias c='clear'

# branch that merged work lands in: origin/develop if the repo has one, else the remote default
_merged_target() {
	git rev-parse -q --verify refs/remotes/origin/develop >/dev/null && echo origin/develop && return
	git symbolic-ref -q --short refs/remotes/origin/HEAD && return
	echo "No origin/develop or origin/HEAD (run: git remote set-head origin -a)" >&2
	return 1
}

# gbc used to be an alias, and a live shell re-sourcing this file would expand it in the definition below
unalias gbc 2>/dev/null

# gbc: delete local branches already merged into the target branch
# * marks the current branch, + one checked out in another worktree
gbc() {
	local base
	git fetch --prune origin || return 1
	base=$(_merged_target) || return 1
	git branch --merged "$base" | grep -vE '^[*+]' | sed 's/^ *//' | grep -vE '^(develop|master|main)$' | grep -vE '^release' | grep -vxF "${base#origin/}" | xargs -r git branch -d
}

# gbcr: same on the shared remote. -n lists without deleting, otherwise it asks first
gbcr() {
	local branches base reply
	git fetch --prune origin || return 1
	base=$(_merged_target) || return 1
	branches=$(git branch -r --merged "$base" --format='%(refname:short)' | sed 's|^origin/||' | grep -vE '^(origin|HEAD|develop|master|main)$' | grep -vE '^release' | grep -vxF "${base#origin/}")
	if [ -z "$branches" ]; then
		echo "Nothing merged to delete"
		return 0
	fi
	echo "$branches"
	[ "$1" = -n ] && return 0
	echo
	read "reply?Delete these ${#${(f)branches}} branches on origin? [y/N] "
	[ "$reply" = y ] && echo "$branches" | xargs -r git push origin --delete
}

# private
[ -f $HOME/.private.zsh ] && source $HOME/.private.zsh

# shell integrations
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
if [[ $- == *i* ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi