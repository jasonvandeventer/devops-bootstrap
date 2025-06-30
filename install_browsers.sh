#!/bin/bash
# install_browsers.sh - Enhanced version
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

if command -v xrandr >/dev/null 2>&1 || [ -n "${DISPLAY:-}" ]; then
  log "🌐 Installing Brave browser..."
  
  curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
    https://brave.com/static-assets/BraveSoftware/brave-browser-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    > /etc/apt/sources.list.d/brave-browser-release.list

  apt update && apt install -y brave-browser
  log "✅ Brave browser installed successfully"
else
  log "🚫 GUI not detected. Skipping Brave install."
fi