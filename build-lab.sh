#!/bin/bash

source ./set-prettyOutputVariables.sh

# if [[ ! $0 =~ .*/bash ]]; then
#     echo -e "\n${WARN}You did not run this script by executing${RSET} ${VERB}source $0${RSET} ${WARN}or${RSET} ${VERB}. $0${RSET} ${WARN}Please try again.${RSET}\n"
#     exit 1
# fi

echo -e "${LINE_ASCII_CONSOLE}\n"
echo -e "${VERB}Setting up the lab environment...${RSET}"

# Set up alias for lab command
alias lab="cd /workspaces/$(basename $GITHUB_REPOSITORY)"
echo -e "\n${HIGH}You can now issue the command ${VERB}lab${RSET} ${HIGH}to quickly get back to the working directory.${RSET}"

# By default, do not install Ruby documentation as it is not needed.
echo "gem: --no-document" >"${HOME}/.gemrc"

# Install VS Code extensions
echo -e "${VERB}Installing Code extensions...${RSET}\n"
code --install-extension shopify.ruby-lsp
code --install-extension ms-azuretools.vscode-docker
code --install-extension esbenp.prettier-vscode
code --install-extension oderwat.indent-rainbow

# Install tree utility if not already installed
echo -e "${LINE_ASCII_CONSOLE}\n"
if ! command -v tree &>/dev/null; then
    echo -e "${VERB}Installing the \"tree\" utility.${RSET}"
    sudo apt-get install -y tree
else
    echo -e "${HIGH}The \"tree\" utility is already installed.${RSET}"
fi

# Ensure required Perl and Python modules are installed
echo -e "${LINE_ASCII_CONSOLE}\n"
echo -e "${VERB}Installing required Perl and Python modules...${RSET}"
sudo apt-get update
sudo apt-get install -y libwww-perl python3-urllib3

# Copy extra CA certificates and update CA certificates
echo -e "${LINE_ASCII_CONSOLE}\n"
echo -e "${VERB}Copying extra CA certificates and updating CA certificates...${RSET}"
if [ -f .devcontainer/extra-ca.pem ]; then
    sudo mkdir -p /usr/local/share/ca-certificates/extra
    sudo cp .devcontainer/extra-ca.pem /usr/local/share/ca-certificates/extra/extra-ca.crt
    sudo update-ca-certificates
else
    echo -e "${WARN}extra-ca.pem not found in .devcontainer directory${RSET}"
fi

# Install InSpec (CINC Auditor Distribution) if not already installed
echo -e "${LINE_ASCII_CONSOLE}\n"
if ! command -v inspec &>/dev/null; then
    echo -e "${VERB}Installing InSpec (CINC Auditor Distribution) into the Environment.${RSET}"
    wget --no-check-certificate -O - https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-auditor -v 6
else
    echo -e "${HIGH}InSpec is already installed.${RSET}"
fi

# Install rubocop Ruby gem if not already installed
echo -e "${LINE_ASCII_CONSOLE}\n"
if ! gem list --installed rubocop &>/dev/null; then
    echo -e "${VERB}Installing the \"rubocop\" Ruby gem.${RSET}"
    gem install rubocop
else
    echo -e "${HIGH}The \"rubocop\" Ruby gem is already installed.${RSET}"
fi

# Install and use Node.js 22
echo -e "${LINE_ASCII_CONSOLE}\n"
echo -e "${VERB}Installing and using Node.js 22...${RSET}"
export NVM_DIR="$HOME/.nvm"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    echo -e "${VERB}Installing NVM...${RSET}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"
fi

. "$NVM_DIR/nvm.sh"
if ! nvm install 22 || ! nvm use 22; then
    echo -e "${FAIL}Failed to install and use Node.js 22${RSET}"
    exit 1
fi

# Verify Node.js version
echo -e "${VERB}Verifying Node.js version...${RSET}"
if ! node -v | grep "v22"; then
    echo -e "${FAIL}Node.js version is not 22${RSET}"
    exit 1
fi

# Update npm to the latest major version
echo -e "${VERB}Updating npm to the latest major version...${RSET}"
if ! npm install -g npm@latest; then
    echo -e "${FAIL}Failed to update npm${RSET}"
    exit 1
fi

# Install MITRE SAF CLI if not already installed
echo -e "${LINE_ASCII_CONSOLE}\n"
if ! command -v saf &>/dev/null; then
    echo -e "${VERB}Installing MITRE SAF CLI into the Environment.${RSET}"
    npm install -g @mitre/saf
else
    echo -e "${HIGH}MITRE SAF CLI is already installed.${RSET}"
fi

# Set up Docker containers
echo -e "${LINE_ASCII_CONSOLE}\n"
echo -e "${VERB}Setting up the required Docker containers.${RSET}"
docker-compose -f docker-compose.yml up -d

echo -e "${LINE_ASCII_CONSOLE}\n"
echo -e "${HIGH}Setup complete.${RSET}\n"
