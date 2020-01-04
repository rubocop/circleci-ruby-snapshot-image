#!/usr/bin/env bash

repository=`mktemp -d`
git clone --depth 1 --branch master https://github.com/circleci/circleci-images.git $repository
pushd $repository/ruby

# We only want to build a "latest" tagged image
TAG="latest"

# The manifest is usually a file like e.g.
# https://github.com/docker-library/official-images/blob/56ceaf0cee/library/ruby
# that the circleci-images script fetches with `curl`.
# To make things easy, we write a file in the same format, with one tag (latest)
# and tell the script that this file is available with the `file:` protocol.
echo "Tags: ${TAG}" > manifest

# Builds a new Docker image with BASE_REPO:TAG as its base image.
MANIFEST_SOURCE="file://$repository/ruby/manifest" \
  BASE_REPO="rubocophq/ruby-snapshot" \
  NAME="Ruby" \
  source ../shared/images/generate.sh

popd

cp -v $repository/ruby/images/${TAG}/Dockerfile Dockerfile.circle
