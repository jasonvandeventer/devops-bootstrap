#!/bin/bash
# setup_zsh.sh - Enhanced with better shell handling
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

TARGET_USER="${SUDO_USER:-$USER}"

log "🐚 Installing zsh..."
apt install -y zsh

# Check if zsh is already the default shell
CURRENT_SHELL=$(getent passwd "$TARGET_USER" | cut -d: -f7)
ZSH_PATH=$(which zsh)

if [[ "$CURRENT_SHELL" != "$ZSH_PATH" ]]; then
  log "🔄 Changing default shell to zsh for $TARGET_USER..."
  chsh -s "$ZSH_PATH" "$TARGET_USER"
else
  log "✅ zsh is already the default shell for $TARGET_USER"
fi

log "🎨 Installing Oh My Zsh..."
export RUNZSH=no
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "✅ Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

log "⚡ Installing Powerlevel10k theme..."
[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

log "💡 Installing zsh plugins..."
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

log "✅ Zsh setup completed"