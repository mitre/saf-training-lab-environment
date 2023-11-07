#!/bin/bash

source ./set-prettyOutputVariables.sh

if [[ ! $0 =~ .*/bash ]]
then
    echo -e "${WARN}You did not run this script by executing${RSET} ${VERB}source $0${RSET} ${WARN}or${RSET} ${VERB}. $0${RSET} ${WARN}Please try again.${RSET}" 
    exit 1
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Setting up the lab environment...${RSET}"

alias lab="cd /workspaces/$(basename $GITHUB_REPOSITORY)"
echo -e "${HIGH}You can issue the command 'lab' to quickly get back to the working directory.${RSET}"

# Do not install Ruby documentation as it is not needed.
echo "gem: --no-ri --no-rdoc" > ${lab}/.gemrc

# Accept the Chef license so the students are not prompted when first
#     starting Inspec.
export CHEF_LICENSE="accept-silent"


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Installing Code extensions.${RSET}\n"

code --install-extension shopify.ruby-lsp
code --install-extension ms-azuretools.vscode-docker
code --install-extension esbenp.prettier-vscode


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
    curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c stable -P inspec 
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

if ! command -v saf &> /dev/null
then
    echo -e "${VERB}Installing MITRE SAF CLI into the Environment.${RSET}"
    npm install -g npm
    npm install -g @mitre/saf
else
    echo -e "${HIGH}MITRE SAF CLI is already installed.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Setting up the required Docker containers.${RSET}"

docker-compose -f docker-compose.yml up -d


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${HIGH}Setup complete.${RSET}\n"
