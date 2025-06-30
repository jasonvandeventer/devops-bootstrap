#!/bin/bash
# github_setup.sh - Enhanced version
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

log "🐙 Installing GitHub CLI..."

# Ensure curl is available
type -p curl >/dev/null || apt install curl -y

# Add GitHub CLI repository
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
    dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
    https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list

apt update && apt install -y gh

log "✅ GitHub CLI installed"

# Interactive login if running in terminal
if [ -t 1 ] && [ -n "${DISPLAY:-}${SSH_CLIENT:-}" ]; then
  log "🔐 Launching GitHub login..."
  echo "Please complete the GitHub authentication process..."
  sudo -u "${SUDO_USER:-$USER}" gh auth login
else
  log "⏭️ Skipping interactive gh auth (non-interactive shell)."
  log "💡 Run 'gh auth login' manually after setup completion."
fi

log "✅ GitHub setup completed"