#!/usr/bin/env bash

repository=`mktemp -d`
git clone --depth 1 --branch master https://github.com/circleci/circleci-images.git $repository
pushd $repository/ruby

# We only want to build a "latest" tagged image
TAG="latest" && echo "Tags: ${TAG}" > manifest

# Builds a new Docker image with BASE_REPO:TAG as its base image.
MANIFEST_SOURCE="file://$repository/ruby/manifest" \
  BASE_REPO="bquorning/ruby-snapshot" \
  NAME="Ruby" \
  source ../shared/images/generate.sh

popd

cp -v $repository/ruby/images/latest/Dockerfile Dockerfile.circle
