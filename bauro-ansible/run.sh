#!/usr/bin/env bash
ansible-playbook -i inventory/local raffler.yml --extra-vars="names_file=$1"