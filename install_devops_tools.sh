#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Docker
if ! command -v docker &>/dev/null; then
  apt install -y docker.io
  systemctl enable --now docker
  usermod -aG docker "${SUDO_USER:-$USER}"
fi

# AWS CLI v2
if ! command -v aws &>/dev/null; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install
  rm -rf awscliv2.zip aws
fi

# Terraform
if ! command -v terraform &>/dev/null; then
  curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"     > /etc/apt/sources.list.d/hashicorp.list
  apt update && apt install -y terraform
fi

# kubectl
if ! command -v kubectl &>/dev/null; then
  curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv kubectl /usr/local/bin/
fi

# Minikube
if ! command -v minikube &>/dev/null; then
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube-linux-amd64
  mv minikube-linux-amd64 /usr/local/bin/minikube
fi
