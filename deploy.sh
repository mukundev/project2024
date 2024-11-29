#!/bin/bash

# Default values
IMAGE_NAME="#!/bin/bash

# Default values
IMAGE_NAME="#!/bin/bash

# Default values
IMAGE_NAME="project2024-react-app"
IMAGE_TAG="latest"
CONTAINER_NAME="project2024-react-app-1"
DOCKER_HOST="mukundhandocker" 
DOCKER_PORT="" 
REGISTRY="docker.io"  
RESTART_POLICY="unless-stopped"

# Parse the tag and container name if provided as arguments
if [ ! -z "$1" ]; then
  IMAGE_TAG=$1
fi

if [ ! -z "$2" ]; then
  CONTAINER_NAME=$2
fi

# Full image path including registry (if applicable)
IMAGE_PATH="$REGISTRY/$IMAGE_NAME:$IMAGE_TAG"

# Docker commands
echo "Deploying Docker image: $IMAGE_PATH to container: $CONTAINER_NAME"

# Log into the Docker registry (optional if private registry)
# docker login $REGISTRY  # Uncomment if you are using a private registry

# Pull the latest Docker image
echo "Pulling image $IMAGE_PATH..."
docker pull "$IMAGE_PATH"

# Check if the container is already running, and stop it if so
EXISTING_CONTAINER=$(docker ps -q -f name="$CONTAINER_NAME")

if [ ! -z "$EXISTING_CONTAINER" ]; then
  echo "Stopping existing container $CONTAINER_NAME..."
  docker stop "$CONTAINER_NAME"
  docker rm "$CONTAINER_NAME"
else
  echo "No existing container found with the name $CONTAINER_NAME"
fi

# Run the container with the new image
echo "Deploying new container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --restart $RESTART_POLICY \
  -p 8080:80 \  
  "$IMAGE_PATH"

# Check if the container started successfully
if [ $? -eq 0 ]; then
  echo "Deployment successful: $CONTAINER_NAME is running!"
else
  echo "Error: Deployment failed!"
  exit 1
fi
"

