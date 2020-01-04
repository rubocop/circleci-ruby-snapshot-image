[![CircleCI](https://circleci.com/gh/rubocop-hq/circleci-ruby-snapshot-image/tree/master.svg?style=svg)](https://circleci.com/gh/rubocop-hq/circleci-ruby-snapshot-image/tree/master)

We needed to test the RuboCop projects on CircleCI against a “nightly” build of Ruby. But the official Ruby docker images (https://github.com/docker-library/ruby) do not include a nightly build, and so the CircleCI Docker images (https://github.com/circleci/circleci-images) also didn’t include one. So we build and publish these images ourselves.

Once per day, the “daily” workflow is run on CircleCI, building a new Docker image from the Ruby “Nightly Snapshot”, and from that image a CircleCI compatible Docker image is built.

The images are published to https://hub.docker.com/r/rubocophq/ruby-snapshot/ and https://hub.docker.com/r/rubocophq/circleci-ruby-snapshot/

#### How does this work? (AKA: How do I debug a failed build 6 months from now?)

We use Dockerfile.ruby to build an image that we tag `rubocophq/ruby-snapshot:latest`. We then use Dockerfile.circle to build an image that we tag `rubocophq/circleci-ruby-snapshot:latest`.

Dockerfile.ruby is based off one of the dockerfiles being used to build the official Ruby images. Our script generate-ruby-dockerfile.sh removes version specific information, and does a `git clone` instead of a `wget` to get the latest source. On CI, this script is run daily to confirm that our generated Dockerfile.ruby is still up to date. If this check fails, I probably will have to look at recent commits at https://github.com/docker-library/ruby/commits/master to see what changed there.

Dockerfile.circle is based off the dockerfiles that CircleCI use to build *their* Ruby images, based off the official images. Our script generate-circle-dockerfile.sh clones their repository and writes a `manifest` file with the only tag version of Ruby that we need to build: `latest`. https://github.com/circleci/circleci-images/blob/ae701e4733/ruby/generate-images shows how they generate their dockerfiles (by sourcing `shared/images/generate.sh`), and we do the same to build our Dockerfile. On CI, this script is run daily to confirm that our generated Dockerfile.circle is still up to date. If this check fails, I probably will have to look at recent commits at https://github.com/circleci/circleci-images/commits/master to see what changed there.
