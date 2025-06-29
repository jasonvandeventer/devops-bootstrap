#!/bin/bash
set -e

sudo apt update && sudo apt upgrade -y

# Essential CLI tools
sudo apt install -y \
    curl wget git unzip gnupg lsb-release ca-certificates apt-transport-https \
    htop fzf bat zoxide neofetch software-properties-common \
    tree net-tools iproute2 nmap dnsutils tcpdump telnet

# Symlink batcat to bat (Ubuntu specific)
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat 2>/dev/null || true
