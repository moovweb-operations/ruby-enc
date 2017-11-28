#!/bin/bash

set -e
set -x

apt-get update
apt-get install -y nodejs

bundle install
bundle exec rspec

gem install fury
gem build enc_dashboard.gemspec
fury push --as=moovweb --api-token=$BUNDLE_GEM__FURY__IO *.gem