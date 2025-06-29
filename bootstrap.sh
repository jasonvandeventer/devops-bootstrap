#!/bin/bash
set -e

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

for script in "${SCRIPTS[@]}"; do
  if [[ -f "$script" ]]; then
    echo "🔧 Executing $script..."
    chmod +x "$script"
    ./"$script"
    echo "✅ Completed $script"
  else
    echo "❌ $script not found. Skipping."
  fi
done

echo -e "\n🎉 DevOps bootstrap complete. Please restart your terminal or reboot."
