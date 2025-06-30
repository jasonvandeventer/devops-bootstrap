#!/bin/bash
# setup_dotfiles.sh - Enhanced with backup and fixed IFS
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

DOTFILE_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$DOTFILE_USER")
ZSHRC_PATH="$USER_HOME/.zshrc"

log "⚙️ Setting up dotfiles for $DOTFILE_USER..."

# Backup existing .zshrc if it exists
if [ -f "$ZSHRC_PATH" ]; then
  BACKUP_PATH="$ZSHRC_PATH.backup.$(date +%s)"
  log "💾 Backing up existing .zshrc to $BACKUP_PATH"
  cp "$ZSHRC_PATH" "$BACKUP_PATH"
fi

log "📝 Creating new .zshrc configuration..."
cat <<EOF > "$ZSHRC_PATH"
# Enhanced .zshrc configuration
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  kubectl
  terraform
  aws
)

source \$ZSH/oh-my-zsh.sh

# Custom aliases
alias k="kubectl"
alias d="docker"
alias tf="terraform"
alias cls="clear"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Enhanced aliases for new tools
alias k9="k9s"
alias hh="helm"

# Zoxide initialization
eval "\$(zoxide init zsh)"

# Custom functions
kns() {
  kubectl config set-context --current --namespace=\$1
}

kctx() {
  kubectl config use-context \$1
}

# PATH additions
export PATH="\$HOME/.local/bin:\$PATH"

# Enable Powerlevel10k instant prompt if available
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi
EOF

# Set proper ownership
chown "$DOTFILE_USER":"$DOTFILE_USER" "$ZSHRC_PATH"

log "✅ Dotfiles setup completed"