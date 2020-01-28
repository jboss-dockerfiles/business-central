#!/bin/bash

# ***************************************************
# jBPM Server Full - Docker image build script
# ***************************************************

IMAGE_NAME="jboss/jbpm-server-full"
IMAGE_TAG="latest"


# Build the container image.
echo "Building the Docker container for $IMAGE_NAME:$IMAGE_TAG.."
docker build --rm -t $IMAGE_NAME:$IMAGE_TAG .
echo "Build done"
