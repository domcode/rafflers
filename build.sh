#!/bin/bash

echo "Using docker(`docker version -f "{{.Server.Version}} / {{.Client.Version}}"`) to build container images..."

if [[ "$1" && "$1" != "--rebuild" ]]; then
    dockerfiles=("$1/Dockerfile")
elif [[ "${RAFFLER}" && "${RAFFLER}" != "--rebuild" ]]; then
    dockerfiles=("${RAFFLER}/Dockerfile")
else
    dockerfiles=$(ls */Dockerfile)
fi

for file in $dockerfiles; do
	dir=${file:0:-11}
	tag="domcode/raffler:${dir/-/_}"
	if [[ $1 == "--rebuild" || $2 == "--rebuild" || $(docker images | awk '{print $1}' | grep -c '^'"$tag"'$') -eq 0 ]]; then
		echo "Building $tag from $dir"
		docker build -q -t "$tag" "$dir"
		if [[ $? != 0 ]]; then
			echo "Build failed!"
			exit 1
		fi
	else
		echo "Skipping $tag - already exists"
	fi
done
