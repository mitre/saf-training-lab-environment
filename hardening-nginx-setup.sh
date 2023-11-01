#!/bin/bash

echo 'Setting up the NGINX hardening environment...'
cd "$CODESPACE_VSCODE_FOLDER"

echo 'Ensuring that the contents of the "nginx" container is up-to-date.'
docker exec nginx apt-get update

echo 'Installing Python 3 in the "nginx" container.'
docker exec nginx apt-get install -y python3

echo 'Verifying that Python 3 was installed in the "nginx" container.'
docker exec nginx ls /usr/bin | grep python3

echo 'Installing Ansible.'
python3 -m pip install --user ansible

echo 'Cloning the "docker" branch of the NGINX Ansible hardening script.'
git clone --branch docker https://github.com/mitre/ansible-nginx-stigready-hardening.git || true

echo 'Fixing permissions on the NGINX Ansible hardening script directory.'
chmod 755 ansible-nginx-stigready-hardening

echo 'Making the NGINX Ansible hardening script directory the current working directory.'
cd ./ansible-nginx-stigready-hardening

echo 'Setup complete.'
