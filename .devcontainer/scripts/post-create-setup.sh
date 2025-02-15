#!/bin/bash

set -e          # Exit immediately if a command exits with a non-zero status
set -u          # Treat unset variables as an error and exit immediately
set -o pipefail # Consider a pipeline to fail if any command in the pipeline fails

echo "Running post-create-setup.sh"

# Source pretty output variables
source /workspace/.devcontainer/scripts/set-pretty-output-variables.sh

# Load environment variables
source /workspace/.devcontainer/.env

# Set up alias for lab command
echo -e "${VERB}Setting up alias for lab command...${RSET}"
echo "alias lab='cd /workspace'" >>~/.bashrc

# Install dependencies
echo -e "${VERB}Installing dependencies...${RSET}"
if ! sudo apt-get update && sudo apt-get install -y \
    tree \
    curl \
    ca-certificates \
    postgresql postgresql-contrib; then
    echo -e "${FAIL}Failed to install dependencies${RSET}"
    exit 1
fi

# Upgrade to Node.js ${NODE_VERSION}
echo -e "${VERB}Upgrading to Node.js ${NODE_VERSION}...${RSET}"
if ! . ${NVM_DIR}/nvm.sh && nvm install ${NODE_VERSION} && nvm use ${NODE_VERSION}; then
    echo -e "${FAIL}Failed to upgrade Node.js${RSET}"
    exit 1
fi

# Install @mitre/saf and cinc-auditor using environment variables
echo -e "${VERB}Installing SAF-CLI and ${CINC_PACKAGE}v${CINC_VERSION}...${RSET}"
if ! npm install -g @mitre/saf || ! curl -L https://omnitruck.cinc.sh/install.sh -k | sudo bash -s -- -P ${CINC_PACKAGE} -v ${CINC_VERSION}; then
    echo -e "${FAIL}Failed to install @mitre/saf-cli or cinc-auditor${RSET}"
    exit 1
fi

# Set up Docker containers
echo -e "${VERB}Setting up Docker containers...${RSET}"
if ! docker-compose -f /workspace/.devcontainer/docker-compose.yml up -d; then
    echo -e "${FAIL}Failed to set up Docker containers${RSET}"
    exit 1
fi

# Verify installations
echo -e "${VERB}Verifying installations...${RSET}"
if ! node -v || ! npm -v || ! saf --version || ! cinc-auditor --version || ! psql --version; then
    echo -e "${FAIL}One or more installations are not correct${RSET}"
    exit 1
fi

# Verify Docker containers
echo -e "${VERB}Verifying Docker containers...${RSET}"
containersRunning=$(docker ps)
containersMissing=''
verificationSuccessful=true

if ! echo "${containersRunning}" | grep --silent --extended-regexp 'nginx'; then
    verificationSuccessful=false
    containersMissing="${containersMissing}The \"nginx\" container is missing.\n"
fi
if ! echo "${containersRunning}" | grep --silent --extended-regexp 'redhat9'; then
    verificationSuccessful=false
    containersMissing="${containersMissing}The \"redhat9\" container is missing.\n"
    echo -e "${FAIL}Checking logs for redhat9 container...${RSET}"
    docker logs redhat9
fi

echo -e "${HIGH}* Docker is running the following container(s):${RSET}"
echo "${containersRunning}" |
    GREP_COLORS='mt=0;32' \
        grep --color=always --extended-regexp \
        'nginx$|redhat9$|$'
echo -e "${FAIL}${containersMissing}${RSET}"

if $verificationSuccessful; then
    echo -e "${PASS}All verification tests completed successfully.${RSET}\n"
else
    echo -e "${FAIL}One or more verification tests FAILED.${RSET}\n"
fi

# Set up additional aliases
echo -e "${VERB}Setting up additional aliases...${RSET}"
echo "alias ll='ls -la'" >>~/.bashrc

# Clean up
echo -e "${VERB}Cleaning up...${RSET}"
sudo apt-get clean
rm -rf /var/lib/apt/lists/*

echo -e "${PASS}Post-create setup script completed successfully.${RSET}"
