# ROS dockerfile

# Steps
### 1. Build Dockerfile (do once)
`bash build.sh`

### 2. Create and run new container from an image (do once)
`bash create.sh`

### 3. Start a container (do whenever existing container is stopped)
`docker start <containerID> bash`

Example: `docker exec -it 838bab97b5f6 bash`

### 4. Execute a running container (do whenever to do work inside container environment)
`docker exec -it <containerID>`

# Docker commands

## Build dockerfile
`docker build <commands>`  # e.g. see build.sh

## Create and run a new container from an image
`docker run <commands>`  # e.g. see launch.sh

## Start an existing container
`docker start <containerID>`

## Interact with an existing running container
`docker exec -it <containerID>`

## List existing containers, including stopped ones
`docker container ls -a`

## List images
`docker image ls`

## Remove Image
`docker rmi <imageID>`

## Remove container
`docker rm <containerID>`

# Notes
The ENTRYPOINT instruction is used in a dockerfile to configure the executables that will always run after the container is initiated.
