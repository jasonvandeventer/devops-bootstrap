#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

apt update && apt upgrade -y

apt install -y \
  curl wget git unzip gnupg lsb-release ca-certificates apt-transport-https \
  htop fzf bat zoxide neofetch software-properties-common \
  tree net-tools iproute2 nmap dnsutils tcpdump telnet

mkdir -p ~/.local/bin
[ -f /usr/bin/batcat ] && ln -sf /usr/bin/batcat ~/.local/bin/bat
