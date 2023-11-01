#! /bin/bash

echo '
Verify the script returns the following information:
* A "MITRE SAF" version number.
* An "InSpec" version number.
* Two running containers:
  - nginx:latest
  - redhat/ubi8
'

echo -e "Collecting verification information...\n"
npm update -g @mitre/saf &> /dev/null
versionSafe=$(saf --version 2> /dev/null)
versionInspec=$(inspec --version 2> /dev/null)
echo "* MITRE SAF Version: ${versionSafe}" 
echo "* InSpec Version: ${versionInspec}"
echo "* Docker is running the container(s):" &&  docker ps
