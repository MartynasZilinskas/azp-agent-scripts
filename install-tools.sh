#!/usr/bin/env bash
# For debian-12

set -e

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

log "Starting the installation script."

# yq
log "Installing yq..."
wget https://github.com/mikefarah/yq/releases/download/v4.44.2/yq_linux_amd64 -O /usr/bin/yq\
&& chmod +x /usr/bin/yq
log "yq installed successfully."

# jq
log "Installing jq..."
wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 -O /usr/bin/jq\
&& chmod +x /usr/bin/jq
log "jq installed successfully."

# git
log "Installing git..."
sudo apt install git -y
log "git installed successfully."

# docker
log "Setting up Docker repository..."
## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

log "Installing Docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
log "Docker installed successfully."

# azure cli 
log "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
log "Azure CLI installed successfully."

## Extensions
log "Adding Azure DevOps extension to Azure CLI..."
az extension add --name azure-devops
log "Azure DevOps extension added successfully."

log "Installation script completed."