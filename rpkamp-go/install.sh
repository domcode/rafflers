#!/bin/sh

go get github.com/arbovm/levenshtein 2>/dev/null || { echo >&2 "I require go but it's not installed or not available in your PATH. Aborting."; exit 1; }
go build

echo "All done. Type ./raffler <filename> to start."
echo "To specify the number of goroutines use ./raffler -n <integer> <filename>."
echo "The number of goroutines defaults to 1000."
