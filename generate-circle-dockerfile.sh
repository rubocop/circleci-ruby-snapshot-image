#!/usr/bin/env bash

git clone --depth 1 --branch master https://github.com/circleci/circleci-images.git
pushd circleci-images/ruby

# We only want to build a "snapshop" tagged image
TAG="snapshot" && echo "Tags: ${TAG}" > manifest

# Builds a new Docker image with BASE_REPO:TAG as its base image.
MANIFEST_SOURCE="file://$(pwd)/manifest" \
  BASE_REPO="bquorning/ruby-snapshot" \
  NAME="Ruby" \
  source ../shared/images/generate.sh

popd

cp -v circleci-images/ruby/images/snapshot/Dockerfile Dockerfile.circle
