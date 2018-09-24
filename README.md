[![CircleCI](https://circleci.com/gh/bquorning/circleci-ruby-snapshot-image/tree/master.svg?style=svg)](https://circleci.com/gh/bquorning/circleci-ruby-snapshot-image/tree/master)

I needed to test a project on CircleCI against a “nightly” build of Ruby. But the official Ruby docker images (https://github.com/docker-library/ruby) do not include a nightly build, and so the CircleCI Docker images (https://github.com/circleci/circleci-images) also didn’t include one.

Once per day, the “daily” workflow is run on CircleCI, building a new Docker image from the Ruby “Nightly Snapshot”, and from that image a CircleCI compatible Docker image is built.

For now, the image is published to https://hub.docker.com/r/bquorning/circleci-ruby-snapshot/
