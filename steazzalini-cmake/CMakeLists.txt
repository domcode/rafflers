cmake_minimum_required(VERSION 2.8.3)

project(rafflers NONE)

# Verify that `NAMES_PATH' is set
if(NOT NAMES_PATH)
	message(FATAL_ERROR "Hey fox... keep calm and use cmake -DNAMES_PATH=path/to/the/file .")
endif()

# ... and it's a file
if((NOT EXISTS ${NAMES_PATH}) OR (IS_DIRECTORY ${NAMES_PATH}))
	message(FATAL_ERROR "I'd like to have a file to work with...")
endif()

# read the file and set the content into `names_file_content'
file(READ ${NAMES_PATH} names_file_content)

# split `names_file_content' to a list
string(REGEX REPLACE "\n" ";" names_list "${names_file_content}")

# remove empty lines
list(REMOVE_ITEM names_list "")

# get the number of names to choose from
list(LENGTH names_list number_of_names)

# get `number_of_names' number of digits 
string(LENGTH "${number_of_names}" number_of_digits)

# ... to generate a random number that has at `number_of_digits' digits
string(RANDOM LENGTH ${number_of_digits} ALPHABET 0123456789 random_number)

# calculate the modulo as usual
math(EXPR number "${random_number} % ${number_of_names}")

# and get the winner!
list(GET names_list ${number} winner)

message(STATUS "

Rafflers! Rafflers everywhere!

The winner is: ${winner}!
")
