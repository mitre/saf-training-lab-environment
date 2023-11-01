#!/bin/bash

source ./set-prettyOutputVariables.sh


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Verify the script returns the following information:
* A \"MITRE SAF\" version number.
* An \"InSpec\" version number.
* Two running containers:
  - nginx
  - redhat
${RSET}"


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Collecting verification information...${RSET}\n"

npm update -g @mitre/saf &> /dev/null
versionSaf=$(saf --version 2> /dev/null)
versionInspec=$(inspec --version 2> /dev/null)
containersRunning=$(docker ps)
containersMissing=''

if [ -z "${versionSaf}" ]
then
    statusSaf="${FAIL}\"saf\" not installed${RSET}"
else
    statusSaf="${PASS}${versionSaf}${RSET}"
fi

if [ -z "${versionInspec}" ]
then
    statusInspec="${FAIL}\"inspec\" not installed${RSET}"
else
    statusInspec="${PASS}${versionInspec}${RSET}"
fi

if ! echo "${containersRunning}" | grep --silent --extended-regexp 'nginx'
then
   containersMissing="${containersMissing}The \"nginx\" container is missing.\n"
fi
if ! echo "${containersRunning}" | grep --silent --extended-regexp 'redhat8'
then
   containersMissing="${containersMissing}The \"redhat8\" container is missing.\n"
fi

echo -e "${HIGH}* MITRE SAF Version:${RSET} ${statusSaf}"
echo -e "${HIGH}* InSpec Version:${RSET} ${statusInspec}"
echo -e "${HIGH}* Docker is running the following container(s):${RSET}"
echo "${containersRunning}" | \
    GREP_COLORS='mt=0;32' \
    grep --color=always --extended-regexp \
    'nginx$|redhat8$|$'
echo -e "${FAIL}${containersMissing}${RSET}"


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${HIGH}Verification complete.${RSET}\n"
