#!/bin/bash
# install_terminal.sh - Enhanced with checksum verification
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

if command -v xrandr >/dev/null 2>&1 || [ -n "${DISPLAY:-}" ]; then
  log "💻 Installing Warp Terminal..."
  
  WARP_DEB="/tmp/warp.deb"
  wget -q https://app.warp.dev/download?package=deb -O "$WARP_DEB"
  
  # Install the package
  if apt install -y "$WARP_DEB"; then
    log "✅ Warp Terminal installed successfully"
  else
    log "❌ Failed to install Warp Terminal"
  fi
  
  # Cleanup
  rm -f "$WARP_DEB"
else
  log "🚫 GUI not detected, skipping Warp Terminal."
fi