# AWK raffler

##Usage:

	$ cat ../example_names | awk -v seed=$RANDOM -f raffle.awk

It feels a bit like cheating though, as awk does not have a decent srand() method, or a way to feed entropy to it.
We are using the shells `$RANDOM` to initialize the randomer. Otherwise, it will return the same value in the same 
second.
