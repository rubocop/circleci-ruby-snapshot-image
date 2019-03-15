#!/usr/bin/env bash

curl https://raw.githubusercontent.com/docker-library/ruby/master/2.6/stretch/Dockerfile |

  sed 's/^ENV RUBY_MAJOR 2\.6$//' |
  sed 's/^ENV RUBY_VERSION 2\.6\.[0-9][0-9]*$//' |
  sed 's/^ENV RUBY_DOWNLOAD_SHA256 [0-9a-f]\{64\}$//' |
  sed 's|&& wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" ||' |
  sed 's/&& echo "$RUBY_DOWNLOAD_SHA256 \*ruby.tar.xz" | sha256sum -c - //' |
  sed 's|tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1|git clone --depth 1 https://github.com/ruby/ruby.git /usr/src/ruby|' |
  sed 's/&& rm ruby.tar.xz //' |

  cat > Dockerfile.ruby
