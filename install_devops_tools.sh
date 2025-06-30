#!/bin/bash
# install_devops_tools.sh - Enhanced with additional tools
set -euo pipefail
IFS=$'\n\t'

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Docker
if ! command -v docker &>/dev/null; then
  log "🐳 Installing Docker..."
  apt install -y docker.io
  systemctl enable --now docker
  usermod -aG docker "${SUDO_USER:-$USER}"
  log "✅ Docker installed"
else
  log "✅ Docker already installed"
fi

# AWS CLI v2
if ! command -v aws &>/dev/null; then
  log "☁️ Installing AWS CLI v2..."
  AWSCLI_ZIP="/tmp/awscliv2.zip"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$AWSCLI_ZIP"
  unzip -q "$AWSCLI_ZIP" -d /tmp/
  /tmp/aws/install
  rm -rf "$AWSCLI_ZIP" /tmp/aws
  log "✅ AWS CLI v2 installed"
else
  log "✅ AWS CLI already installed"
fi

# Terraform
if ! command -v terraform &>/dev/null; then
  log "🏗️ Installing Terraform..."
  curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
  apt update && apt install -y terraform
  log "✅ Terraform installed"
else
  log "✅ Terraform already installed"
fi

# kubectl
if ! command -v kubectl &>/dev/null; then
  log "⚓ Installing kubectl..."
  KUBECTL_VERSION=$(curl -Ls https://dl.k8s.io/release/stable.txt)
  curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv kubectl /usr/local/bin/
  log "✅ kubectl installed"
else
  log "✅ kubectl already installed"
fi

# Helm
if ! command -v helm &>/dev/null; then
  log "⛵ Installing Helm..."
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm-stable-debian.list
  apt update && apt install -y helm
  log "✅ Helm installed"
else
  log "✅ Helm already installed"
fi

# k9s
if ! command -v k9s &>/dev/null; then
  log "🐕 Installing k9s..."
  K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | jq -r '.tag_name')
  curl -sL "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" | tar xzf - -C /tmp
  mv /tmp/k9s /usr/local/bin/
  chmod +x /usr/local/bin/k9s
  log "✅ k9s installed"
else
  log "✅ k9s already installed"
fi

# Minikube
if ! command -v minikube &>/dev/null; then
  log "🎡 Installing Minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube-linux-amd64
  mv minikube-linux-amd64 /usr/local/bin/minikube
  log "✅ Minikube installed"
else
  log "✅ Minikube already installed"
fi

# Dive (Docker image analysis)
if ! command -v dive &>/dev/null; then
  log "🤿 Installing Dive..."
  DIVE_VERSION=$(curl -s https://api.github.com/repos/wagoodman/dive/releases/latest | jq -r '.tag_name')
  curl -sL "https://github.com/wagoodman/dive/releases/download/${DIVE_VERSION}/dive_${DIVE_VERSION#v}_linux_amd64.tar.gz" | tar xzf - -C /tmp
  mv /tmp/dive /usr/local/bin/
  chmod +x /usr/local/bin/dive
  log "✅ Dive installed"
else
  log "✅ Dive already installed"
fi

log "🎯 All DevOps tools installation completed"
