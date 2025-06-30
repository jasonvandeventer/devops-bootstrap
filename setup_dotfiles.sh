#!/bin/bash
set -euo pipefail
IFS=$'
	'

DOTFILE_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$DOTFILE_USER")

cat <<EOF > "$USER_HOME/.zshrc"
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source \$ZSH/oh-my-zsh.sh
alias k="kubectl"
alias d="docker"
alias tf="terraform"
alias cls="clear"
eval "$(zoxide init zsh)"
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
PROMPT='[%n@%m %~] ${vcs_info_msg_0_} %# '
EOF

chown "$DOTFILE_USER":"$DOTFILE_USER" "$USER_HOME/.zshrc"
