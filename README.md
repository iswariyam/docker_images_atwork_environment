# Docker Image for MAS @work
This repository contains the dockerfile to build the docker image for MAS industrial robotics build environment. The docker image provides an **Ubuntu 16.04 based ROS-Kinetic** environment with all the necessary ros packages and dependencies already installed. Hence, it is sufficient to clone the MAS industrial robotics repository and perform a hassle free catkin build. <br>
Note : This image can also be used for building and testing any ROS Kinetic package

Advantages of using this image over a local build:
* All necessary ROS dependencies and packages come bundled with the image
* Containers can easily be started by using docker compose
* Hassle free catkin build without any environment issues
* No user rights issues when creating/cloning folders from within the container
* ROS nodes and ROS master can be launched from within the container and can also communicate with nodes/clients running outside the container, on the local Ubuntu machine
* Supports GUI rendering for *gazebo* and *rviz*
* Source code for the ROS packages is stored locally and is only volume mounted in the container

## Using the Image from Docker Hub

* To use the image, first ensure docker engine and docker compose is installed on your machine. If not follow the intructions on the official docker website.
* Download the sample docker-compose.yml file from [this repository](https://github.com/iswariyam/docker_images_atwork_environment/blob/kinetic/docker-compose.yml) and modify the following based on your requirements:
  * Change /home/iswariya/Documents/Robocup to the folder where you have cloned the MAS industrial robotics repository or where you want your catkin workspace to be created
  * Modify the nvidia-390 with the version of nvidia driver installed in your system
  * $HOME/.rviz:/home/kinetic_user/.rviz is optional. Favorite Rviz configurations which are stored in your local file system will be mounted onto your docker container
* Then run the following command from the folder containing the docker-compose.yml file. This spins up a container based on the [iswariyam/mas_industrial_robotics:kinetic](https://hub.docker.com/repository/docker/iswariyam/mas_industrial_robotics/general) image
```sh
docker-compose up
```
Note: The very first time you run this command, the latest image will be pulled from docker-hub
* To run commands inside the container open multiple bash sessions using
```sh
docker exec -it <container name> bash
```
This allows from launching different ROS nodes from different bash terminals of the same container
* To stop and remove the container, use
```sh
docker-compose down
```

## Manually building the image
* It is also possible to locally build the image using the dockerfile in this repository. To build the image use the following command
```sh
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=$USER <image name> .
```
* The locally built image can then used along with the existing docker-compose file by modifying the image name from `iswariyam/mas_industrial_robotics:latest` to \<image name\> and following the previously mentioned instructions.
