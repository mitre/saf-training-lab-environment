#!/bin/bash

# Source pretty output variables
source ${containerWorkspaceFolder}/.devcontainer/scripts/set-pretty-output-variables.sh

# Set up alias for lab command
echo "alias lab='cd ${containerWorkspaceFolder}'" >>~/.bashrc

# Set up Docker containers
docker-compose -f ${containerWorkspaceFolder}/.devcontainer/docker-compose.yml up -d

# Rest of your existing verification code
# ...existing code...
