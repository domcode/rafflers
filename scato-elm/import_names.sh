#!/bin/sh

if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

echo "module Names where" > Names.elm
echo "" >> Names.elm
echo "list : List String" >> Names.elm
echo "list =" >> Names.elm

grep ".\+" $1 | head -n 1 | sed "s/\(.*\)/  [ \"\\1\"/" >> Names.elm
grep ".\+" $1 | tail -n +2 | sed "s/\(.*\)/  , \"\\1\"/" >> Names.elm

echo "  ]" >> Names.elm
echo "" >> Names.elm

