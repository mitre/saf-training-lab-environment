#! /bin/bash

source ./prettyOutput.sh
alias lab="cd ${CODESPACE_VSCODE_FOLDER}"


echo "${LINE_ASCII_CONSOLE}"

echo -e "${VERB}Installing Code extensions.${RSET}"

code --install-extension shopify.ruby-lsp
code --install-extension ms-azuretools.vscode-docker
code --install-extension esbenp.prettier-vscode


echo "${LINE_ASCII_CONSOLE}"

echo -e "${VERB}Installing the \"tree\" utility.${RSET}"
sudo apt-get install -y tree


echo "${LINE_ASCII_CONSOLE}"

if ! command -v inspec &> /dev/null
then
  echo -e "${VERB}Installing InSpec into the Environment.${RSET}"
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c stable -P inspec 
else
  echo -e "${INFO}InSpec is already installed.${RSET}"
fi


echo "${LINE_ASCII_CONSOLE}"

echo -e "${VERB}Installing the \"rubocop\" Ruby gem.${RSET}"

gem install rubocop


echo "${LINE_ASCII_CONSOLE}"

if ! command -v saf &> /dev/null
then
  echo -e "${VERB}Installing MITRE SAF CLI into the Environment.${RSET}"
  npm install -g npm
  npm install -g @mitre/saf 
else
  echo -e "${INFO}MITRE SAF CLI is already installed.${RSET}"
fi


echo "${LINE_ASCII_CONSOLE}"

echo -e "${VERB}Setting up the required Docker containers.${RSET}"

docker-compose -f docker-compose.yml up -d


echo "${LINE_ASCII_CONSOLE}"

echo 'Setup complete.'
