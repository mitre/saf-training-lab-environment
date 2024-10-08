# saf-training-lab-environment

The InSpec Assessor Lab is a GitHub environment that makes it quick and easy for you to start learning and working on executing your own InSpec profiles.

It is also a great, quick, and easy way to test and demonstrate what you have learned or collaborate with others to get help with what you are working on.

## Overview of the Lab

The repository is setup to be very low overhead, we use a simple `build-lab.sh` script to quickly add the tools you need to get started easily, along with two containers to act as testing targets.

## Lab Components

- CodeSpaces Linux Base Community Image
  - <https://github.com/microsoft/vscode-dev-containers/tree/main/containers/codespaces-linux>
- InSpec Omnitruk install of the latest InSpec
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

To use the lab:

1. Make sure you've signed in to your GitHub Account

2. On the [SAF Training repo](https://github.com/mitre/saf-training-lab-environment/tree/main), click the green 'Use this template' dropdown button and select 'Create a new repository'

    ![green button with the words 'use this template' in white text](https://user-images.githubusercontent.com/79539195/213498628-934c3343-4b9a-4488-9295-d21840e766f6.png)

    ![green dropdown with 2 options, the first one says 'create a new repository' and is highlighted with a red box. the second option says 'open in a codespace'](https://user-images.githubusercontent.com/79539195/213499867-0a2bbff2-9593-443d-a8c5-dd9170ddca9e.png)

3. Check to make sure your username is the owner of the new repository and enter a name for your repository.
    We recommend using the name `saf-training-lab-environment` for ease. Additionally, feel free to make your repository public, if it isn't already.

    ![form to create a new repository based off of the SAF training lab environment template](https://github.com/user-attachments/assets/87d8aa26-e00c-4933-a18d-fe3259c12757)


4. Click the 'Create repository from template' button at the bottom

    > **Note**
    >
    > If the button is greyed out, check to make sure you've selected your username as the owner, and named the repository.

    ![green button that says 'create repository from template'](https://user-images.githubusercontent.com/79539195/213503629-13ecb85b-c173-4f8b-ba1b-be6cd194a9f7.png)

5. Wait for your repository to open up, then click the 'Code' drop down button

    ![green button that says 'code'](https://user-images.githubusercontent.com/79539195/213504430-e0417daf-e1e9-40b2-9c82-541a7f766ced.png) 

6. After clicking the 'Code' button, a drop down menu should display, with a 'Local' and a 'Codespace' option. Select the 'Codespace' tab, then click the button that says 'Create codespace on main' 

    > **Note**
    >
    > Please make sure to read the [Codespace section](https://github.com/mitre/saf-training-lab-environment/blob/updates/README.md#note) of this README, as GitHub has updated their policy about Codespaces.

    ![codespaces menu](https://user-images.githubusercontent.com/79539195/213504777-b74cf75a-6dec-4a39-8c52-a5ff4a8b07c3.png)

7. A new tab in your browser should open up with your Codespace. It should open up the README.md file, with a terminal at the bottom featuring your own username. 

   ![view of codespace when it first opens up](https://github.com/user-attachments/assets/72513063-a937-4514-a5fb-8df129275bcb)

8. In the terminal, run the `build-lab.sh` script:

    ```sh
    source ./build-lab.sh
    ```

    Once the script finishes your terminal should display something like the following, right before your username and the path to your codespace:

    ![image of terminal after running the lab-setup command](https://github.com/user-attachments/assets/19a7cfed-317d-47fc-bf2e-67530e495c48)

    Your environment should have the MITRE SAF CLI installed as `saf`, InSpec installed as `inspec`, and two running docker containers tagged as 'nginx' and 'redhat8'.

9. Once complete, you can verify the setup in your environment with the `test-lab.sh` script:

    ```sh
    ./test-lab.sh
    ```

    Which should return something like the following:

    ```sh
    _______________________________________________________________________________________________________________
    
    Verify the script returns the following information:
    * A "MITRE SAF" version number.
    * An "InSpec" version number.
    * Two running containers:
      - nginx
      - redhat
    
    _______________________________________________________________________________________________________________
    
    Collecting verification information...
    
    * MITRE SAF Version: @mitre/saf/1.2.34 linux-x64 node-v20.8.1
    * InSpec Version: 5.22.29
    * Docker is running the following container(s):
    CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS     NAMES
    c114494b9812   redhat/ubi8    "/bin/bash"              38 minutes ago   Up 38 minutes             redhat8
    944568b8768c   nginx:latest   "/docker-entrypoint.…"   38 minutes ago   Up 38 minutes   80/tcp    nginx
    
    _______________________________________________________________________________________________________________
    
    All verification tests completed successfully.
  
    ```

## Codespaces

> **Note**
>
> Previously, the SAF Training courses utilized GitHub Codespaces as a way for users to learn and work on executing InSpec profiles.
> GitHub has updated their policy so that Codespaces can be used for a certain amount of time before the user gets billed.
> If you have a free GitHub account, you're given 120 core hours per month.
> This means that if you use a 2-core machine, and your codespace runs for 8 hours, you've used up 16 (2 mulitplied by 8 = 16) core hours out of the 120.
> You can read more about it here:
> <https://docs.github.com/en/codespaces/overview#using-github-codespaces>

All of your active Codespaces can be found here:
<https://github.com/codespaces>

From the above link, you can access all of your codespaces, and stop the codespace as well.
![image of codespace options](https://user-images.githubusercontent.com/79539195/213740523-639e2dd0-763b-47b8-b038-97195f32c04d.png)

***Docker Container Restart May be Needed*** 

Occasionally, you may have to restart your Docker containers:

1. Run: `docker ps`
2. If your containers are not running, then just run: `build-lab.sh`
3. Run: `docker ps` or `test-lab.sh` to verify that your containers are running in your environment.

## Adding Services and Software

Your repository is yours to command, you have full `sudo` access and can install any software or services you like, run databases, web-servers, etc. and expose any ports that you might need to do your work.

## Creating a Pull Request

<https://www.digitalocean.com/community/tutorials/how-to-create-a-pull-request-on-github>

Go for it and if for some reason you break your environment, just start a new one.

### NOTICE

© 2018-2023 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.
