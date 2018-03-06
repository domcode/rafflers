#!/usr/bin/regina

/************************************/
/*    DomCode prize raffler.        */
/*    www.domcode.org               */
/*    Written for REGINA REXX 3.9.1 */
/*    regina-rexx.sourceforge.net/  */
/*    By Job van Achterberg         */
/*    Happy Hacking                 */
/************************************/

if arg() == 0 then do
    say 'Usage: raffler.rexx [file]'
    exit 1
end

parse arg names

is_readable = stream(names, C, READABLE)

if is_readable == 0 then do
    say 'ERROR:' arg(1) 'cannot be opened for reading.'
    exit 1
end

amount = lines(names, C)

if amount == 0 then do
    say 'ERROR: no lines in file.'
    exit 1
end

index = random(1, amount)

winner = linein(names, index)

say 'We have a winner: -->' winner '<--'
