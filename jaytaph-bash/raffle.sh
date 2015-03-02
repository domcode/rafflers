#!/bin/bash

PROMPT_COMMAND='echo -e "\033[0;32mThe raffle-winner:\033[0m \033[1;33m$(cat /raffle.txt | sort -R | head -n 1)\033[0m"'

