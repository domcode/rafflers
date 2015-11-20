#!/usr/bin/env bash

# Create a dir to share names file with container
NAMES_DIR="/tmp/raffler_names"
mkdir -p $NAMES_DIR

# Copy names file passed as argument to names dir
SCRIPT_PATH=`realpath $0`
WORKING_DIR=`dirname ${SCRIPT_PATH}`
NAMES_FILE=`realpath $WORKING_DIR/$1`
cp $NAMES_FILE $NAMES_DIR/current

# Raffle a raffler ;-)
declare -a RAFFLER_NAMES=('basbl_zsh' 'lucasvanlierop_cobol' 'rjkip_elixir' 'sgoettschkes_haskell' 'shawnmccool_scala')
RANDOM_RAFFLER=${RAFFLER_NAMES[$RANDOM % ${#RAFFLER_NAMES[@]} ]}

# run raffler in container with names dir mounted
CONTAINER_NAME="${RANDOM_RAFFLER}_raffler"
echo -e "Raffling using \033[91m$RANDOM_RAFFLER\e[0m"
echo -e "\033[92m"
docker run -v $NAMES_DIR:/var/names $CONTAINER_NAME
echo -e "\e[0m"
