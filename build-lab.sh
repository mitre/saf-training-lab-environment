#!/bin/bash

source ./set-prettyOutputVariables.sh

if [[ ! $0 =~ .*/bash ]]
then
    echo -e "\n${WARN}You did not run this script by executing${RSET} ${VERB}source $0${RSET} ${WARN}or${RSET} ${VERB}. $0${RSET} ${WARN}Please try again.${RSET}\n" 
    exit 1
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Setting up the lab environment...${RSET}"

alias lab="cd /workspaces/$(basename $GITHUB_REPOSITORY)"
echo -e "\n${HIGH}You can now issue the command ${VERB}lab${RSET} ${HIGH}to quickly get back to the working directory.${RSET}"

# By default, do not install Ruby documentation as it is not needed.
# Note: The '.gemrc' file must go in the user's home directory.
echo "gem: --no-document" > "${HOME}/.gemrc"

# Accept the Chef license so the students are not prompted when first
#     starting Inspec.
export CHEF_LICENSE="accept-silent"


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Installing Code extensions.${RSET}\n"

code --install-extension shopify.ruby-lsp
code --install-extension ms-azuretools.vscode-docker
code --install-extension esbenp.prettier-vscode

# This can help students see indention errors, especially in the YAML files.
code --install-extension oderwat.indent-rainbow


echo -e "${LINE_ASCII_CONSOLE}\n"

if ! command -v tree &> /dev/null
then
    echo -e "${VERB}Installing the \"tree\" utility.${RSET}"
    sudo apt-get install -y tree
else
    echo -e "${HIGH}The \"tree\" utility is already installed.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

if ! command -v inspec &> /dev/null
then
    echo -e "${VERB}Installing InSpec into the Environment.${RSET}"
    curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c stable -P inspec -v 5
else
    echo -e "${HIGH}InSpec is already installed.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

if ! gem list --installed rubocop &> /dev/null
then
    echo -e "${VERB}Installing the \"rubocop\" Ruby gem.${RSET}"
    gem install rubocop
else
    echo -e "${HIGH}The \"rubocop\" Ruby gem is already installed.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

# Heimdall Lite & SAF CLI use Node v18
nvm install 18 &> /dev/null
nvm use 18 &> /dev/null

if ! command -v saf &> /dev/null
then
    echo -e "${VERB}Installing MITRE SAF CLI into the Environment.${RSET}"
    npm install -g npm
    npm install -g @mitre/saf
else
    echo -e "${HIGH}MITRE SAF CLI is already installed.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

# First check for Heimdall Lite repo
if ! ls -A ./dev_repos/heimdall2 &> /dev/null
then
    echo -e "${VERB}Pulling down MITRE Heimdall Lite repository into the Environment.${RSET}"
    git clone https://github.com/mitre/heimdall2 dev_repos/heimdall2
else
    echo -e "${HIGH}MITRE Heimdall Lite repository is already present.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

# Then check for Node packages
if ! ls -A ./dev_repos/heimdall2/node_modules &> /dev/null
then
    echo -e "${VERB}Installing required Node packages for MITRE Heimdall Lite repository.${RSET}"
    cd dev_repos/heimdall2
    yarn install --frozen-lockfile
    cd ../..
else
    echo -e "${HIGH}MITRE Heimdall Lite Node packages are already present.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

# First check for SAF CLI repo
if ! ls -A ./dev_repos/saf &> /dev/null
then
    echo -e "${VERB}Pulling down MITRE SAF CLI repository into the Environment.${RSET}"
    git clone https://github.com/mitre/saf dev_repos/saf
else
    echo -e "${HIGH}MITRE SAF CLI repository is already present.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

# Then check for Node packages
if ! ls -A ./dev_repos/saf/node_modules &> /dev/null
then
    echo -e "${VERB}Installing required Node packages for MITRE SAF CLI repository.${RSET}"
    cd dev_repos/saf
    npm ci
    cd ../..
else
    echo -e "${HIGH}MITRE SAF CLI Node packages are already present.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Setting up the required Docker containers.${RSET}"

docker-compose -f docker-compose.yml up -d


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${HIGH}Setup complete.${RSET}\n"
