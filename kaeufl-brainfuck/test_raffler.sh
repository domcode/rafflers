#!/bin/bash
#
# draw N random names and print a histogram
#
echo -ne "" > test_raffler.out
for i in {1..10}
do
	#(pwgen -s -y 2 1 && cat example_names) | ./raffler | grep -Po '(?<=Fortune is kind to you, )[^!]*' >> test_raffler.out
	rand=$( dd if=/dev/urandom bs=1 count=2 2> /dev/null)
	(echo $rand && cat example_names) | ./raffler | grep -Po '(?<=Fortune is kind to you, )[^!]*' >> test_raffler.out
	echo -ne "."
done
echo ""
cat test_raffler.out | awk '{h[$0]++}END{for(i in h){print h[i],i|"sort -rn"}}'