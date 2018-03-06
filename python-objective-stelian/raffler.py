#!/usr/bin/python

import sys;
import os.path;
import random;
from time import sleep;

# Check for argument, should be at least 1
if len(sys.argv) < 2:
    sys.exit('Please provide a file path argument');

filePath = sys.argv[1];

# Check if the argument is actually a file
if not os.path.isfile(filePath):
    sys.exit('Please provide a path to an actual file');

# Read all lines
with open(filePath) as f:
    candidates = f.read().splitlines();

# Ensure "true random"

unsureIfWinner = True;

while unsureIfWinner:
   winner = random.choice(candidates);
   nb = raw_input('Master, we have selected ' + winner +'. Is it random enough? ')
   
   if 'yes' == nb: 
      unsureIfWinner = False;
      break;	

print 'And the winner is ... '
sleep(random.randint(1,7))
print 'wait for it ... '
sleep(random.randint(1,7)) 
print winner 
