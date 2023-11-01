#!/bin/bash

source ./prettyOutput.sh


echo "${LINE_ASCII_CONSOLE}"

echo -e "${VERB}
Verify the script returns the following information:
* A \"MITRE SAF\" version number.
* An \"InSpec\" version number.
* Two running containers:
  - nginx:latest
  - redhat/ubi8
${RSET}"


echo "${LINE_ASCII_CONSOLE}"

echo -e "${VERB}Collecting verification information...${RSET}\n"

npm update -g @mitre/saf &> /dev/null
versionSafe=$(saf --version 2> /dev/null)
versionInspec=$(inspec --version 2> /dev/null)
containersRunning=$(docker ps)

echo -e "${HIGH}* MITRE SAF Version:${RSET} ${PASS}${versionSafe}${RSET}"
echo -e "${HIGH}* InSpec Version:${RSET} ${PASS}${versionInspec}${RSET}"
echo -e "${HIGH}* Docker is running the container(s):${RSET}\n${PASS}${containersRunning}${RSET}"


echo "${LINE_ASCII_CONSOLE}"

echo -e "${HIGH}Verification complete.${RSET}"
