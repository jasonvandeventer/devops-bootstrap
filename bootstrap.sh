#!/bin/bash
set -euo pipefail
IFS=$'
	'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

LOG_FILE="${LOG_FILE:-/var/log/devops-bootstrap.log}"
mkdir -p "$(dirname "$LOG_FILE")"
exec > >(tee -a "$LOG_FILE") 2>&1

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
