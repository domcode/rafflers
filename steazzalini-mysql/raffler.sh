#!/bin/bash

set -e

bash /entrypoint.sh mysqld >/dev/null 2>&1 &
mysqladmin --silent --wait=30 -uroot -praffler ping >/dev/null 2>&1
sleep 5
cat raffler.sql | mysql -u root -praffler
