#!/usr/bin/env bash

# Provide likely winner.
mkdir -p names
echo "Reinier Kip" > names/current

# Win. Every time.
dockerfiles=$(ls */Dockerfile)
for file in $dockerfiles; do
    dir=${file:0:-11}
    container=${dir/-/_}"_raffler"
    echo "Testing $container from $dir"
    docker build -t "$container" "$dir"
    if [ $? != 0 ]; then
        echo "Docker image $dir could not be built"
        exit 1;
    fi
    winner=`docker run -v $(pwd)/names:/var/names "$container"`
    if [[ "$winner" != *"Reinier Kip"* ]]; then
        echo "$dir did not elect 'Reinier Kip' as the winner"
        exit 1;
    fi
done

echo "Winner, winner, chicken dinner."
