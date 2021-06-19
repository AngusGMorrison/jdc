#!/bin/bash

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# Bind the server IP to all addresses rather than localhost. This makes the
# Rails server rout incoming requests to the container IP instead of localhost.
bundle exec rails s -b 0.0.0.0
