#! /bin/bash

echo "Installing Code extensions"
code --install-extension shopify.ruby-lsp
code --install-extension ms-azuretools.vscode-docker
code --install-extension esbenp.prettier-vscode

alias lab="cd /workspaces/saf-training-lab-environment"
sudo apt-get install -y tree
if ! command -v inspec &> /dev/null
then
  echo "Installing InSpec into the Environment"
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c stable -P inspec 
fi

gem install rubocop

if ! command -v saf &> /dev/null
then
  echo "Installing MITRE SAF CLI into the Environment"
  npm install -g npm
  npm install -g @mitre/saf 
fi

docker-compose -f docker-compose.yml up -d
