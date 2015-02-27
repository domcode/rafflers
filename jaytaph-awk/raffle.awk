BEGIN { print "Welcome to the AWK raffler."; idx = 0; srand(seed); }
{ names[idx++] = $0 }
END { n = int(idx * rand()); print n; print "And the winner is: ", names[n]; }
