#!/bin/bash
set -e

./install_packages.sh
./install_browsers.sh
./install_terminal.sh
./install_devops_tools.sh
./setup_zsh.sh
./setup_dotfiles.sh
./install_vscode.sh
./github_setup.sh

echo "✅ DevOps Bootstrap Completed. Please restart your terminal or reboot."
