#!/bin/bash

# *********************************************************************
# JBoss Business-Central Workbench Showcase - Docker image build script
# *********************************************************************

IMAGE_NAME="kiegroup/business-central-workbench-showcase"
IMAGE_TAG="7.61.0.Final"


# Build the container image.
echo "Building the Docker container for $IMAGE_NAME:$IMAGE_TAG.."
docker build --rm -t $IMAGE_NAME:$IMAGE_TAG .

echo "Build done"
