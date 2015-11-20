#!/usr/bin/env bash

# Create a dir to share names file with container
NAMES_DIR="/tmp/raffler_names"
mkdir -p $NAMES_DIR

# Copy names file passed as argument to names dir
SCRIPT_PATH=`realpath $0`
WORKING_DIR=`dirname ${SCRIPT_PATH}`
NAMES_FILE=`realpath $WORKING_DIR/$1`
cp $NAMES_FILE $NAMES_DIR/current

# run raffler in container with names dir mounted
CONTAINER_NAME="sgoettschkes_haskell_raffler"
echo "Raffling using '$CONTAINER_NAME':"
docker run -v $NAMES_DIR:/var/names $CONTAINER_NAME
