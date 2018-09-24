[![CircleCI](https://circleci.com/gh/rubocop-hq/circleci-ruby-snapshot-image/tree/master.svg?style=svg)](https://circleci.com/gh/rubocop-hq/circleci-ruby-snapshot-image/tree/master)

We needed to test the RuboCop projects on CircleCI against a “nightly” build of Ruby. But the official Ruby docker images (https://github.com/docker-library/ruby) do not include a nightly build, and so the CircleCI Docker images (https://github.com/circleci/circleci-images) also didn’t include one. So we build and publish such an image ourselves.

Once per day, the “daily” workflow is run on CircleCI, building a new Docker image from the Ruby “Nightly Snapshot”, and from that image a CircleCI compatible Docker image is built.

The images are published to https://hub.docker.com/r/rubocophq/circleci-ruby-snapshot/
