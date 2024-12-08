# saf-training-lab-environment

The InSpec Assessor Lab is a GitHub environment that makes it quick and easy for you to start learning and working on executing your own InSpec profiles.

It is also a great, quick, and easy way to test and demonstrate what you have learned or collaborate with others to get help with what you are working on.

## Overview of the Lab

The repository is setup to be very low overhead, we use a simple `build-lab.sh` script to quickly add the tools you need to get started easily, along with two containers to act as testing targets.

## Lab Components

- CodeSpaces Linux Base Community Image
  - <https://github.com/microsoft/vscode-dev-containers/tree/main/containers/codespaces-linux>
- InSpec Omnitruck install of the latest InSpec
  - `curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c stable -P inspec`
- MITRE SAF CLI
  - <https://saf-cli.mitre.org>
  - <https://github.com/mitre/saf>
- MITRE Heimdall Lite
  - <https://heimdall-lite.mitre.org>
  - <https://github.com/mitre/heimdall2>
- Docker Compose File which starts:
  - RedHat UBI8 Container
  - NGINX Web Server Container

## Using the Lab

Refer to the instructions [here](https://mitre.github.io/saf-training/resources/02.html#instructions).

## Adding Services and Software

Your repository is yours to command, you have full `sudo` access and can install any software or services you like, run databases, web-servers, etc. and expose any ports that you might need to do your work.

## Creating a Pull Request

<https://www.digitalocean.com/community/tutorials/how-to-create-a-pull-request-on-github>

Go for it and if for some reason you break your environment, just start a new one.

### NOTICE

© 2018-2024 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.
