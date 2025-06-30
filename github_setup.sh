#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

type -p curl >/dev/null || apt install curl -y

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
    dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
    https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list

apt update && apt install -y gh

if [ -t 1 ]; then
  echo "🔐 Launching GitHub login..."
  gh auth login
else
  echo "⏭️ Skipping interactive gh auth (non-interactive shell)."
fi
