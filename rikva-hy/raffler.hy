#!/usr/bin/env hy
(import sys)
(import random)

(setv input_file (get sys.argv 1))

(with [f (open input_file)]
  (print (.strip (random.choice (.readlines f)))))
