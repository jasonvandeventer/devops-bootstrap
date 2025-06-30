#!/bin/bash
# install_vscode.sh - Enhanced version
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

if command -v xrandr >/dev/null 2>&1 || [ -n "${DISPLAY:-}" ]; then
  log "💻 Installing Visual Studio Code..."
  
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
  install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
  
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" \
    > /etc/apt/sources.list.d/vscode.list
  
  apt update && apt install -y code
  rm -f /tmp/packages.microsoft.gpg
  
  log "✅ VS Code installed successfully"
else
  log "🚫 GUI not detected, skipping VS Code install."
fi