#!/usr/bin/env bash

if [ "$1" == "" ]; then
	echo "Usage: ./raffle <file>"
	exit 1
fi

# Get path to names file
SCRIPT_PATH=$(realpath "$0")
WORKING_DIR=$(dirname "$SCRIPT_PATH")
NAMES_FILE=$(realpath "$WORKING_DIR/$1")

# Raffle a raffler ;-)
declare RAFFLER_TAGS=($(docker images | awk '{print $1":"$2}' | grep domcode/raffler))

RANDOM_RAFFLER_TAG=${RAFFLER_TAGS[$RANDOM % ${#RAFFLER_TAGS[@]} ]}

# run raffler in container with names dir mounted
echo -e "Raffling using \033[91m$RANDOM_RAFFLER_TAG\e[0m"
echo -e "\033[92mAnd the winner is: "
docker run -v $NAMES_FILE:/var/names.txt "$RANDOM_RAFFLER_TAG"
echo -e "\e[0m"
