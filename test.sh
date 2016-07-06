#!/usr/bin/env bash

# Provide likely winner. Some rafflers support trailing newline, other do not.
mkdir -p .names-test
echo "Reinier Kip" > .names-test/current

# Win. Every time.
if [[ "$1" ]]; then
    dockerfiles=("$1/Dockerfile")
else
    dockerfiles=$(ls */Dockerfile)
fi

for file in $dockerfiles; do
    dir=${file:0:-11}
    tag="domcode/raffler:${dir/-/_}"

    echo "Testing $tag from $dir"

    # Some rafflers don't support trailing newline and may pick the empty line as the winner.
    non_spec_rafflers="kaeufl-brainfuck markredeman-cpp rdohms-lolcode remyhonig-elisp"
    if [[ " $non_spec_rafflers " == *" $dir "* ]]; then
        continue
    fi

    # Run the raffler 5 times so we're kind of sure it doesn't pick the empty line as the winner.
    for attempt in 1 2 3 4 5; do
        winner=`docker run --rm=true -v $(pwd)/.names-test:/var/names "$tag"`
        if [[ "$winner" != *"Reinier Kip"* ]]; then
            echo "$dir did not elect 'Reinier Kip' as the winner after raffle attempt $attempt:"
            echo
            echo "  $winner"
            exit 1;
        fi
    done
done

echo "Winner, winner, chicken dinner."
