args  <- commandArgs(TRUE)
names <- t(read.table(args, sep = '\n', stringsAsFactors = FALSE))
sample(names, 1)