#!/bin/bash
rand=$( dd if=/dev/urandom bs=1 count=2 2> /dev/null)
(echo $rand && cat $1) | ./raffler