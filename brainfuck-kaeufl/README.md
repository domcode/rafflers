[brainfuck](https://en.wikipedia.org/wiki/Brainfuck/) raffler
=============================================================
Note that a brainfuck compiler written in assembler is included, but in theory (not tested) any other 8-bit compiler / interpreter that supports "wrapping", i.e. cells may under-/overflow, should work likewise.

Installation
------------
Run the install.sh. It will try to fetch the nasm package using apt-get, compile the compiler :-), and run a test script. On success it should output 10 random draws on screen.

Usage
-----
Since brainfuck does not support any I/O but stdin and stdout, a shell script is provided for convenience which pipes the contents of the input file and a 16bit random seed into the raffler. 

Just run
```bash
./raffler.sh FILENAME
```

Notes and known issues
----------------------
 * The list separator is adjustable and defaults to '\n'.
 * Sorry no utf-8, ASCII only, this is 8-bit brainfuck.
 * The random draws should be uniform. The brainfuck code includes a [very simplistic](http://en.wikipedia.org/wiki/Linear_congruential_generator) pseudo-random number generator, which is initialized using a two byte random seed (read from stdin). 
   Since there is no way to save an internal state across runs (without storing it outside and passing it back in), it has to be initialized with a different seed everytime. This is done by raffler.sh
   which first reads two fresh random bytes from /dev/urandom. Subsequently the bf code generates
   8 bit pseudo random numbers until one is found that falls into the right range. This limits
   the maximum number of names in the list to 256 (should suffice for domcode, I hope)

   The script test_raffler.sh is provided to test the randomness of the draws. 
   A test output for 1000 draws will be something like this:
   ```
   81 Westley
   80 Prince Humperdinck
   79 The Dread Pirate Roberts
   77 Inigo Montoya
   76 Valerie
   76 The Albino
   74 Count Tyrone Rugen
   72 Vizzini
   72 The Princess Bride
   67 The Grandfather / Narrator
   66 The Impressive Clergyman
   65 Fezzik
   59 The Grandson
   56 Miracle Max
   ```

 * See raffler.b for the pure brainfuck beauty. If you want to understand what's going on a bit better, find a commented version in raffler_commented.b.
   raffler.b has been generated from raffler_commented.b using [this script](https://github.com/kaeufl/bfformatter), which has been hacked together quickly for that purpose.

Acknowledgements
----------------
Thanks to [Urban Müller](http://web.archive.org/web/20031017195011/http://wuarchive.wustl.edu/~umueller/) for inventing brainfuck, to [Brian Raiter](http://www.muppetlabs.com/~breadbox/software/tiny/bf.asm.txt) for writing and GPL'ing the brainfuck compiler contained in this repository and
to [Jeffry Johnston](http://esolangs.org/wiki/User:Calamari) from the esolangs.org wiki, from
which the pseudo random number generator code was taken.