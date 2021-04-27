#!/bin/bash

# *************************************************************
# jJBoss Business-Central Workbench - Docker image build script
# *************************************************************

IMAGE_NAME="jboss/business-central-workbench"
IMAGE_TAG="7.53.0.Final"


# Build the container image.
echo "Building the Docker container for $IMAGE_NAME:$IMAGE_TAG.."
docker build --rm -t $IMAGE_NAME:$IMAGE_TAG .
echo "Build done"
