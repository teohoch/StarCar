#!/bin/bash
set -e

echo "Installing and updating gems"

git fetch --all
git reset --hard origin/master

cp -fr /database.yml /StarCar/config/database.yml


bundle install && bundle update

echo "Creating database if it doesn't exist and runing migrations"
rake db:create 2>/dev/null
rake db:migrate 2>/dev/null

exec "$@"
