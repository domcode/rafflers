#! /usr/bin/env nix-shell
#! nix-shell -i bash -p gnuapl 
cp $1 ./attendants.txt
apl -f raffle.apl
