#!/bin/bash

source ./set-prettyOutputVariables.sh

if [[ ! $0 =~ .*/bash ]]
then
    echo -e "\n${WARN}You did not run this script by executing${RSET} ${VERB}source $0${RSET} ${WARN}or${RSET} ${VERB}. $0${RSET} ${WARN}Please try again.${RSET}\n" 
    exit 1
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Setting up the NGINX hardening environment...${RSET}"

cd "/workspaces/$(basename $GITHUB_REPOSITORY)"


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Ensuring that the contents of the \"nginx\" container is up-to-date.${RSET}"
docker exec nginx apt-get update

echo -e "${VERB}Installing Python 3 in the \"nginx\" container.${RSET}"
docker exec nginx apt-get install -y python3

echo -e "${VERB}Verifying that Python 3 was installed in the \"nginx\" container.${RSET}"
if docker exec nginx which python3
then
    docker exec nginx ls -al $(docker exec nginx which python3)
else
    echo -e "${FAIL}Python 3 does not seem to be installed in the \"nginx\" container.${RSET}"
fi

echo -e "${VERB}Installing Ansible.${RSET}"
python3 -m pip install --user ansible

echo -e "${VERB}Verifying that Ansible was installed.${RSET}"
if which ansible
then
    ls -al $(which ansible)
else
    echo -e "${FAIL}Ansible does not seem to be installed.${RSET}"
fi


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Cloning the \"docker\" branch of the NGINX Ansible hardening script.${RSET}"
git clone --branch docker https://github.com/mitre/ansible-nginx-stigready-hardening.git || true

echo -e "${VERB}Fixing permissions on the NGINX Ansible hardening script directory.${RSET}"
chmod 755 ansible-nginx-stigready-hardening

echo -e "${VERB}Making the NGINX Ansible hardening script directory the current working directory.${RSET}"
COMMAND='cd ./ansible-nginx-stigready-hardening'
if [[ ! $0 =~ .*/bash ]]
then
    echo -e "${WARN}If you did not run this script by executing${RSET} ${VERB}source $0${RSET} ${WARN}or${RSET} ${VERB}. $0${RSET} ${WARN}then you must manually execute the${RSET} ${VERB}${COMMAND}${RSET} ${WARN}command.${REST}" 
fi
${COMMAND}
unset COMMAND


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${HIGH}Setup complete.${RSET}\n"
