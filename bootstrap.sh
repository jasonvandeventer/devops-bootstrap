#!/bin/bash
# bootstrap.sh - Enhanced version with improvements
set -euo pipefail
IFS=$'\n\t'

# Configuration
TARGET_RELEASE="${TARGET_RELEASE:-25.04}"
LOG_FILE="/var/log/devops-bootstrap.log"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Structured logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Cleanup function
cleanup() {
    log "🧹 Cleaning up temporary files..."
    # Remove any temporary files that might exist
    rm -f /tmp/warp.deb /tmp/awscliv2.zip 2>/dev/null || true
}

# Setup logging and cleanup
mkdir -p "$(dirname "$LOG_FILE")"
exec > >(tee -a "$LOG_FILE") 2>&1
trap cleanup EXIT

cd "$SCRIPT_DIR"

SCRIPTS=(
  "install_packages.sh"
  "install_browsers.sh"
  "install_terminal.sh"
  "install_devops_tools.sh"
  "setup_zsh.sh"
  "setup_dotfiles.sh"
  "install_vscode.sh"
  "github_setup.sh"
)

START=$(date +%s)
log "🚀 Starting DevOps bootstrap process"

for script in "${SCRIPTS[@]}"; do
  if [[ -f "$script" ]]; then
    log "🔧 Executing $script..."
    if bash "$script"; then
      log "✅ Completed $script"
    else
      log "❌ Failed to execute $script"
      exit 1
    fi
  else
    log "❌ $script not found. Skipping."
  fi
done

END=$(date +%s)
log "⏱️ Bootstrap duration: $((END - START)) seconds"
log "🎉 DevOps bootstrap complete. Please restart your terminal or reboot."

log "🔄 Checking if OS upgrade is needed..."

CURRENT_RELEASE=$(lsb_release -rs)

if [[ "$CURRENT_RELEASE" == "$TARGET_RELEASE" ]]; then
  log "✅ Already on Ubuntu $TARGET_RELEASE. Skipping OS upgrade."
else
  log "🚀 Upgrading from $CURRENT_RELEASE to $TARGET_RELEASE..."

  apt update
  apt install -y update-manager-core

  sed -i 's/^Prompt=.*/Prompt=normal/' /etc/update-manager/release-upgrades

  if do-release-upgrade -f DistUpgradeViewNonInteractive -m desktop; then
    log "✅ OS upgrade completed successfully"
  else
    log "❌ Upgrade failed. Check /var/log/dist-upgrade for details."
    exit 1
  fi
fi

log "🎯 Bootstrap process completed successfully!"