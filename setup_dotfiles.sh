#!/bin/bash
set -e

cat <<EOF > ~/.zshrc
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source \$ZSH/oh-my-zsh.sh

# Aliases
alias k="kubectl"
alias d="docker"
alias tf="terraform"
alias cls="clear"

# zoxide init
eval "$(zoxide init zsh)"

# Git + K8s prompt context
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
PROMPT='[%n@%m %~] ${vcs_info_msg_0_} %# '
EOF
