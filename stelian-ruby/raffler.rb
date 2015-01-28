#!/usr/bin/env ruby

# Check for an argument, we need an argument, Ross said so
if ARGV.empty?
    puts "You need to point to the participants list"
    exit
end

filePath = ARGV[0]

# Ross also said this argument should be a file and readable
if false == File.exist?(filePath) || false == File.readable?(filePath)
    puts "The argument you passed is not a file or is not readable"
    exit
end

# Ross also said we need it random, so don't return my name
winner = File.readlines(filePath).sample

# Return the random dude, make him happy
puts "And the winner is " + winner
