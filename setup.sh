#!/bin/bash
set -e

cd /usr/local/share/solarnet-db-setup

echo 'Creating SolarNetwork Postgres database...'
./bin/setup-db.sh -m -u solarnet -d solarnetwork

echo 'Creating SolarNetwork unit test Postgres database...'
./bin/setup-db.sh -m -u solartest -d solarnetwork_unittest
