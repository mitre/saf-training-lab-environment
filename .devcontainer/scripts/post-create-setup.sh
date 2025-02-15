#!/bin/bash

set -e          # Exit immediately if a command exits with a non-zero status
set -u          # Treat unset variables as an error and exit immediately
set -o pipefail # Consider a pipeline to fail if any command in the pipeline fails

# Debug output
echo "Running post-create-setup.sh"
echo "containerWorkspaceFolder: ${containerWorkspaceFolder}"
echo "workspaceFolder: ${workspaceFolder}"

# Source pretty output variables
source ${containerWorkspaceFolder}/.devcontainer/scripts/set-pretty-output-variables.sh

# Load environment variables
source ${containerWorkspaceFolder}/.devcontainer/.env

# Set up alias for lab command
echo "Setting up alias for lab command..."
echo "alias lab='cd ${containerWorkspaceFolder}'" >>~/.bashrc

# Install dependencies
echo "Installing dependencies..."
sudo apt-get update && sudo apt-get install -y \
    tree \
    curl \
    ca-certificates \
    postgresql postgresql-contrib || {
    echo "Failed to install dependencies"
    exit 1
}

# Upgrade to Node.js 22
echo "Upgrading to Node.js ${NODE_VERSION}..."
. ${NVM_DIR}/nvm.sh && nvm install ${NODE_VERSION} && nvm use ${NODE_VERSION} || {
    echo "Failed to upgrade Node.js"
    exit 1
}

# Install @mitre/saf-cli and cinc-auditor using environment variables
echo "Installing @mitre/saf-cli and cinc-auditor..."
npm install -g @mitre/saf-cli || {
    echo "Failed to install @mitre/saf-cli"
    exit 1
}
curl -L https://omnitruck.cinc.sh/install.sh -k | bash -s -- -P ${CINC_PACKAGE} -v ${CINC_VERSION} || {
    echo "Failed to install cinc-auditor"
    exit 1
}

# Set up Docker containers
echo "Setting up Docker containers..."
docker-compose -f ${containerWorkspaceFolder}/.devcontainer/docker-compose.yml up -d || {
    echo "Failed to set up Docker containers"
    exit 1
}

# Verify installations
echo "Verifying installations..."
node -v || {
    echo "Node.js is not installed correctly"
    exit 1
}
npm -v || {
    echo "npm is not installed correctly"
    exit 1
}
saf --version || {
    echo "@mitre/saf-cli is not installed correctly"
    exit 1
}
cinc-auditor --version || {
    echo "cinc-auditor is not installed correctly"
    exit 1
}
psql --version || {
    echo "PostgreSQL is not installed correctly"
    exit 1
}

# Set up additional aliases
echo "Setting up additional aliases..."
echo "alias ll='ls -la'" >>~/.bashrc

# Clean up
echo "Cleaning up..."
sudo apt-get clean
rm -rf /var/lib/apt/lists/*

echo "Post-create setup script completed successfully."
