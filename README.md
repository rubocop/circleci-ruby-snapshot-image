I needed to test a project on CircleCI against a “nightly” build of Ruby. But the official Ruby docker images (https://github.com/docker-library/ruby) do not include a nightly build, and so the CircleCI Docker images (https://github.com/circleci/circleci-images) also didn’t include one.

This repository only includes a CircleCI configuration file, which will build a new Docker image from the Ruby “Nightly Snapshot”, and use that to build a CircleCI compatible Docker image.

For now, the image is published to https://hub.docker.com/r/bquorning/circleci-ruby-snapshot/
