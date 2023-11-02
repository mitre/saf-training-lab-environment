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
verificationSuccessful=true


if [ -z "${versionSaf}" ]
then
    verificationSuccessful=false
    statusSaf="${FAIL}\"saf\" is not installed.${RSET}"
else
    statusSaf="${PASS}${versionSaf}${RSET}"
fi

if [ -z "${versionInspec}" ]
then
    verificationSuccessful=false
    statusInspec="${FAIL}\"inspec\" is not installed.${RSET}"
else
    statusInspec="${PASS}${versionInspec}${RSET}"
fi

if ! echo "${containersRunning}" | grep --silent --extended-regexp 'nginx'
then
    verificationSuccessful=false
    containersMissing="${containersMissing}The \"nginx\" container is missing.\n"
fi
if ! echo "${containersRunning}" | grep --silent --extended-regexp 'redhat8'
then
    verificationSuccessful=false
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

if $verificationSuccessful
then
    echo -e "${PASS}All verification tests completed successfully.${RSET}\n"
else
    echo -e "${FAIL}One or more verification tests FAILED.${RSET}\n"
fi
