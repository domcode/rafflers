#!/usr/bin/env bash
if [[ ! -z $1 ]]; then
    ansible-playbook -i inventory/local raffler.yml --extra-vars="names_file=$1"
else
     ansible-playbook -i inventory/local raffler.yml
fi