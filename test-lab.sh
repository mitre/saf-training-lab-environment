#!/bin/bash

source ./set-prettyOutputVariables.sh


echo -e "${LINE_ASCII_CONSOLE}\n"

echo -e "${VERB}Verify the script returns the following information:
* A \"MITRE SAF\" version number.
* An \"InSpec\" version number.
* The Git integrity of the Heimdall Lite and SAF CLI repositories.
* A Node package installation verification for the the Heimdall Lite and SAF CLI repositories.
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

cd dev_repos/heimdall2 &> /dev/null
gitIntegrityHeimdall=$(git status)
yarnCheckHeimdall=$(yarn check --verify-tree)
cd ../saf &> /dev/null
gitIntegritySaf=$(git status)
yarnCheckSaf=$(yarn check --verify-tree)
cd ../.. &> /dev/null

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

if ! echo "${gitIntegrityHeimdall}" | grep --silent --extended-regexp 'working tree clean'
then
    verificationSuccessful=false
    statusGitHeimdall="${FAIL}The Heimdall Lite repository has mismatched files.${RSET}"
else
    statusGitHeimdall="${PASS}The Heimdall Lite repository is in sync with remote.${RSET}"
fi
if ! echo "${yarnCheckHeimdall}" | grep --silent --extended-regexp 'success Folder in sync'
then
    verificationSuccessful=false
    statusNodeHeimdall="${FAIL}The Heimdall Lite repository has mismatched Node packages.${RSET}"
else
    statusNodeHeimdall="${PASS}The Heimdall Lite repository has correct Node packages.${RSET}"
fi

if ! echo "${gitIntegritySaf}" | grep --silent --extended-regexp 'working tree clean'
then
    verificationSuccessful=false
    statusGitSaf="${FAIL}The SAF CLI repository has mismatched files.${RSET}"
else
    statusGitSaf="${PASS}The SAF CLI repository is in sync with remote.${RSET}"
fi
if ! echo "${yarnCheckSaf}" | grep --silent --extended-regexp 'success Folder in sync'
then
    verificationSuccessful=false
    statusNodeSaf="${FAIL}The SAF CLI repository has mismatched Node packages.${RSET}"
else
    statusNodeSaf="${PASS}The SAF CLI repository has correct Node packages.${RSET}"
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
echo -e "${HIGH}* Heimdall repository integrity:${RSET} ${statusGitHeimdall}"
echo -e "${HIGH}* Heimdall Node verification:${RSET} ${statusNodeHeimdall}"
echo -e "${HIGH}* SAF CLI repository integrity:${RSET} ${statusGitSaf}"
echo -e "${HIGH}* SAF CLI Node verification:${RSET} ${statusNodeSaf}"
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
