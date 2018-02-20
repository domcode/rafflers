import random
import sys

with open(sys.argv[1]) as f:
    print random.choice(f.readlines()).rstrip('\n')
