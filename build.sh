#!/bin/bash

echo "Using docker(`docker version -f "{{.Server.Version}} / {{.Client.Version}}"`) to build containers..."

if [[ "$1" && "$1" != "--rebuild" ]]; then
    dockerfiles=("$1/Dockerfile")
else
    dockerfiles=$(ls */Dockerfile)
fi

for file in $dockerfiles; do
	dir=${file:0:-11}
	container=${dir/-/_}"_raffler"
	if [[ $1 == "--rebuild" || $(docker images | awk '{print $1}' | grep -c '^'"$container"'$') -eq 0 ]]; then
		echo "Building $container from $dir"
		docker build -q -t "$container" "$dir"
		if [[ $? != 0 ]]; then
			echo "Build failed!"
			exit 1
		fi
	else
		echo "Skipping $container - already exists"
	fi
done
