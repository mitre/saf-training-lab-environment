#! /bin/bash
npm update -g @mitre/saf
echo "MITRE SAF version: " && saf --version 
echo "InSpec version: " && inspec --version
echo "Docker is running the container(s): " &&  docker ps

