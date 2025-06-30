#!/bin/bash
# install_packages.sh - Enhanced with additional tools
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

log "📦 Updating package lists and upgrading system..."
apt update && apt upgrade -y

log "📦 Installing base packages..."
apt install -y \
  curl wget git unzip gnupg lsb-release ca-certificates apt-transport-https \
  htop fzf bat zoxide neofetch software-properties-common \
  tree net-tools iproute2 nmap dnsutils tcpdump telnet \
  jq

log "📦 Installing yq (YAML processor)..."
YQ_VERSION="v4.40.5"
YQ_BINARY="yq_linux_amd64"
wget -qO /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}"
chmod +x /usr/local/bin/yq

log "🔧 Setting up local bin directory..."
mkdir -p ~/.local/bin
[ -f /usr/bin/batcat ] && ln -sf /usr/bin/batcat ~/.local/bin/bat

log "✅ Base packages installation completed"