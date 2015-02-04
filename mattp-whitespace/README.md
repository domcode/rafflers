# raffler in whitespace

This is the [Whitespace](http://compsoc.dur.ac.uk/whitespace/) entry 
for the raffle.

It does not quite meet the entry rules:

1. Whitespace does not have any filesystem functionality, so it
does not accept the input filename as an argument.  Instead you have
to pipe it in.
2. Whitespace does not have any source of randomness.  The randomness
is added at the build stage, but is then deterministic based on the
file input given.

To run it you will need a Whitespace interpreter: this [uses igorw's
one](https://github.com/igorw/whitespace-php) written in php.

## To run it

After the install.sh has run, you can do:

```bash
cat ../example_names | ./ws-interpreter.php domraffler.ws 
```

## Source

The whitespace programme is actually output from PHPWhitespace, 
by (this example file)[https://github.com/mattparker/phpwhitespace/blob/master/examples/domraffler.php].  In other words, it's written in php, 
converted into Whitespace, which is then run using a Whitespace
interpreter written in php.


## Credits

To [https://twitter.com/igorwhiletrue](Igor Weidler) for the interpreter
and for getting me interested in this.



