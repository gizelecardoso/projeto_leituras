#!/bin/bash

set -euo pipefail

# Install Docker and required utilities
dnf install -y docker

# Enable and start Docker
systemctl enable --now docker

# Install Docker Compose plugin
mkdir -p /usr/local/lib/docker/cli-plugins

curl -fsSL --retry 3 \
  https://github.com/docker/compose/releases/download/v2.32.4/docker-compose-linux-x86_64 \
  -o /usr/local/lib/docker/cli-plugins/docker-compose

chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Allow ec2-user to execute Docker commands
usermod -aG docker ec2-user

# Enable and start Systems Manager Agent
systemctl enable --now amazon-ssm-agent

# Create application directory
mkdir -p /opt/leitura

# Validate installations
docker --version
docker compose version
aws --version
