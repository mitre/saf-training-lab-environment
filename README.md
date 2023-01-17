# saf-training-lab-environment

The InSpec Assessor Lab is a GitHub Codespaces environment that makes it quick and easy for you to start learning and working on executing your own InSpec profiles.

It is also a great quick and easy way to test and demonstrate what you have learned or collaborate with others to get help with what you are working on.
## Overview of the Lab

The Codespece is setup to be very low overhead, we use the base 'Codespace Linux Community Image' along with a simple `setup.sh` script to quickly add the tools you need to get started easily along with two containers to act as testing targets.
### Lab Components

- CodeSpaces Linux Base Community Image
  - <https://github.com/microsoft/vscode-dev-containers/tree/main/containers/codespaces-linux>
- InSpec Omnitruk install of the latest InSpec
  - `curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c stable -P inspec`
- MITRE SAF CLI
  - <https://saf-cli.mitre.org>
- Docker Compose File which starts:
  - RedHat UBI8 Container
  - NGINX Web Server Container

## Using the Lab

To use the lab:
1. Make sure you've signed in to your GitHub Account
2. Click the 'Use this template' dropdown and select 'Create a new repository'
3. Check to make sure your username is the owner of the new repository and enter a name for your repository 
4. Click the 'Create repository' button at the bottom 
5. Wait for your repository to opne up, then click the 'Code' Drop down 
6. We will then install three extentions - Click the extensions box on the left-hand bar. Search and install these three extentions:
 - Ruby
 - Docker
 - Prettier
7. In the terminal, run the `lab-setup.sh` script

```sh
source ./lab-setup.sh
```

Once, this has finished, you should have InSpec installed in your environment, the MITRE SAF CLI and two running docker containers - tagged as `nginx` and `redhat8`.

8. Once complete, you can verify the setup in your environment with the `verify-lab.sh` script:

```sh
./verify-lab.sh
```

Which should return something like:

```sh
MITRE SAF version: 
@mitre/saf/1.1.6 darwin-arm64 node-v18.2.0
InSpec version: 
5.14.0
Docker is running the container(s): 
CONTAINER ID   IMAGE          COMMAND                  CREATED        STATUS         PORTS                NAMES
4f0ceb9b5974   nginx:latest   "/docker-entrypoint.…"   2 months ago   Up 6 minutes   0.0.0.0:80->80/tcp   nginx
```
## Codespaces

### Note:

Previously, the SAF Training courses utilized GitHub Codespaces as a way for users to learn and work on executing InSpec profiles. GitHub has updated their policy so that Codespaces can be used for a certain amount of time before the user gets billed. You can read more about it here: 
- https://docs.github.com/en/codespaces/overview#using-github-codespaces

***Docker Container Restart May be Needed*** 

You may have to restart your docker containers again after you restart your Codespace. To do this:

1. Run: `docker ps`
2. If your containers are not running, then just run: `lab-setup.sh`
3. Run: `docker ps` again to verify that your containers are again running in your environment.

## Adding Services and Software to your Codespace

Your repository is yours to command, you have full `sudo` access and can install any software or services you like, run databases, web-servers, etc. and expose any ports that you might need to do your work.

## Creating a Pull Request

- <https://www.digitalocean.com/community/tutorials/how-to-create-a-pull-request-on-github>

Go for it and if for some reason you break your environment, just start a new one.
### NOTICE

© 2018-2022 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.
