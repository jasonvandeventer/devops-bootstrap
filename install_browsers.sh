#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if command -v xrandr >/dev/null 2>&1 || [ -n "${DISPLAY:-}" ]; then
  curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
    https://brave.com/static-assets/BraveSoftware/brave-browser-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    > /etc/apt/sources.list.d/brave-browser-release.list

  apt update && apt install -y brave-browser
else
  echo "🚫 GUI not detected. Skipping Brave install."
fi
