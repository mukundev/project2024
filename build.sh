#!/bin/bash

# Default image tag
IMAGE_TAG="latest"

# Check if the user provided a custom image tag
if [ ! -z "$1" ]; then
  IMAGE_TAG=$1
fi

# Define the image name
IMAGE_NAME="project2024-react-app"

# Build Docker image
echo "Building Docker image: $IMAGE_NAME:$IMAGE_TAG from Dockerfile in $DOCKERFILE_PATH"
docker build -t "$IMAGE_NAME:$IMAGE_TAG" "$DOCKERFILE_PATH"

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Docker image built successfully!"
else
  echo "Error: Docker build failed!"
  exit 1
fi

