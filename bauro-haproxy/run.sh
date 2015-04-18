#!/usr/bin/env bash

vagrant up --no-provision

if [[ ! -z $1 ]]; then
    NAMES_FILE="$1" vagrant provision
else
     vagrant provision
fi

vagrant ssh <<'ENDSSH'

cd /vagrant/Test/
( ( node_modules/.bin/phantomjs --webdriver=4444 & ) & )
sleep 3
codecept build
codecept run  --steps
logout

ENDSSH

vagrant destroy --force