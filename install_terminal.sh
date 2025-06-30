#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if command -v xrandr >/dev/null 2>&1 || [ -n "${DISPLAY:-}" ]; then
  wget https://app.warp.dev/download?package=deb -O warp.deb
  apt install -y ./warp.deb
  rm warp.deb
else
  echo "🚫 GUI not detected, skipping Warp Terminal."
fi

