#!/usr/bin/env bash

curl https://raw.githubusercontent.com/docker-library/ruby/master/2.6/stretch/Dockerfile |
  sed 's/^ENV.*RUBY_MAJOR .*$//' |
  sed 's/^ENV.*RUBY_VERSION .*$//' |
  sed 's/^ENV.*RUBY_DOWNLOAD_SHA256 .*$//' |
  sed 's/https:\/\/cache.ruby-lang.org\/pub\/ruby\/${RUBY_MAJOR%-rc}\/ruby-$RUBY_VERSION.tar.xz/https:\/\/cache.ruby-lang.org\/pub\/ruby\/snapshot.tar.xz/' |
  sed 's/&& echo "$RUBY_DOWNLOAD_SHA256 \*ruby.tar.xz" | sha256sum -c - \\/\\/' \
  > Dockerfile.ruby
