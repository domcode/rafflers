#!/usr/bin/python

import sys;
import os.path;
import random;

# Check for argument, should be at least 1
if len(sys.argv) < 2:
    sys.exit('Please provide a file path argument');

filePath = sys.argv[1];

# Check if the argument is acutally a file
if not os.path.isfile(filePath):
    sys.exit('Please provide a path to an actual file');

# Read all lines
with open(filePath) as f:
    candidates = f.read().splitlines();

# Pick a random
winner = random.choice(candidates);

# Let them know, they need to know
print 'And the winner is ... ' + winner;
