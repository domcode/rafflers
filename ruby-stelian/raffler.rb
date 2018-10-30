#!/usr/bin/env ruby

# This was tested in production, it works, get over it

# Check for an argument, we need an argument, Ross said so
abort('You need to point to the participants list') if ARGV.empty?

@file_path = ARGV[0]

def file_valid?
  File.exist?(@file_path) || File.readable?(@file_path)
end

# Ross also said this argument should be a file and readable
abort('The argument you passed is not a readable file') unless file_valid?

# Ross also said we need it random, so don't return my name
winner = File.readlines(@file_path).sample

# Return the random person, making them happy
puts "And the winner is #{winner}"
