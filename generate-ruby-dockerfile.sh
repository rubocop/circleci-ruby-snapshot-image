#!/usr/bin/env bash

curl https://raw.githubusercontent.com/docker-library/ruby/master/2.6/stretch/Dockerfile |
  sed 's/^ENV RUBY_MAJOR 2\.6$//' |
  sed 's/^ENV RUBY_VERSION 2\.6\.[0-9][0-9]*$//' |
  sed 's/^ENV RUBY_DOWNLOAD_SHA256 [0-9a-f]\{64\}$//' |
  sed 's|&& wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" ||' |
  sed 's/&& echo "$RUBY_DOWNLOAD_SHA256 \*ruby.tar.xz" | sha256sum -c - //' |
  sed 's|tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1|git clone --depth 1 https://github.com/ruby/ruby.git /usr/src/ruby|' |
  sed 's/&& rm ruby.tar.xz //' |

  # These 4 lines can hopefully be removed soon, after Ruby 2.6.2 is released.
  sed 's/^ENV RUBYGEMS_VERSION 3\.0\.3$//' |
  sed 's|^# make sure bundled "rubygems" is older than RUBYGEMS_VERSION (https://github.com/docker-library/ruby/issues/246)||' |
  sed 's/&& ruby -e '"'"'exit(Gem::Version.create(ENV\["RUBYGEMS_VERSION"\]) > Gem::Version.create(Gem::VERSION))'"'"' \\//' |
  sed 's|&& gem update --system "\$RUBYGEMS_VERSION" && rm -r /root/.gem/ \\||' |

  cat > Dockerfile.ruby
