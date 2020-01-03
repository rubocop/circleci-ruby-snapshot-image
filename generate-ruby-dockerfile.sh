#!/usr/bin/env bash

curl https://raw.githubusercontent.com/docker-library/ruby/master/2.7/buster/Dockerfile |

  sed 's/^ENV RUBY_MAJOR 2\.7$//' |
  sed 's/^ENV RUBY_VERSION 2\.7\.[0-9][0-9]*$//' |
  sed 's/^ENV RUBY_DOWNLOAD_SHA256 [0-9a-f]\{64\}$//' |
  sed 's|wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz"; ||' |
  sed 's/echo "$RUBY_DOWNLOAD_SHA256 \*ruby.tar.xz" | sha256sum --check --strict; //' |
  sed 's|tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1|git clone --depth 1 https://github.com/ruby/ruby.git /usr/src/ruby|' |
  sed 's/rm ruby.tar.xz; //' |
  sed 's/BUNDLE_PATH="$GEM_HOME"/BUNDLE_PATH__SYSTEM=true/' |

  cat > Dockerfile.ruby
