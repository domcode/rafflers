#!/bin/bash

composer install
cp ../example_names ./

echo
echo And the winner is:
vendor/bin/glitch raffler.g example_names

