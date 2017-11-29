#!/bin/bash

set -e
set -x

#apt-get update
#export DEBIAN_FRONTEND=noninteractive
#apt-get install -y nodejs mysql-server
#service mysql start

#bundle install
#bundle exec rake db:create RAILS_ENV=test
#bundle exec rake db:migrate RAILS_ENV=test
#bundle exec rspec

gem install fury
gem build enc_dashboard.gemspec
fury push --as=moovweb --api-token=$BUNDLE_GEM__FURY__IO *.gem