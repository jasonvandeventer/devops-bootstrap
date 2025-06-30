#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if command -v xrandr >/dev/null 2>&1 || [ -n "${DISPLAY:-}" ]; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" \
    > /etc/apt/sources.list.d/vscode.list
  apt update && apt install -y code
  rm -f packages.microsoft.gpg
else
  echo "🚫 GUI not detected, skipping VS Code install."
fi

