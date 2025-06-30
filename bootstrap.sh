#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

LOG_FILE="/var/log/devops-bootstrap.log"
mkdir -p "$(dirname "$LOG_FILE")"
exec > >(tee -a "$LOG_FILE") 2>&1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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

for script in "${SCRIPTS[@]}"; do
  if [[ -f "$script" ]]; then
    echo "🔧 Executing $script..."
    bash "$script"
    echo "✅ Completed $script"
  else
    echo "❌ $script not found. Skipping."
  fi
done

END=$(date +%s)
echo -e "\n⏱️ Bootstrap duration: $((END - START)) seconds"
echo "🎉 DevOps bootstrap complete. Please restart your terminal or reboot."

echo "🔄 Checking if OS upgrade is needed..."

TARGET_RELEASE="25.04"
CURRENT_RELEASE=$(lsb_release -rs)

if [[ "$CURRENT_RELEASE" == "$TARGET_RELEASE" ]]; then
  echo "✅ Already on Ubuntu $TARGET_RELEASE. Skipping OS upgrade."
else
  echo "🚀 Upgrading from $CURRENT_RELEASE to $TARGET_RELEASE..."

  apt update
  apt install -y update-manager-core

  sed -i 's/^Prompt=.*/Prompt=normal/' /etc/update-manager/release-upgrades

  do-release-upgrade -f DistUpgradeViewNonInteractive -m desktop || {
    echo "❌ Upgrade failed. Check /var/log/dist-upgrade for details."
    exit 1
  }
fi
