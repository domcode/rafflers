#!/usr/bin/env bash

echo -e "\033[0;32mThe raffle-winner:\033[0m \033[1;33m$(shuf $1 | head -n 1)\033[0m"
