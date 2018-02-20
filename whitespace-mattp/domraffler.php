<?php
/**
 * This generates a whitespace program to enter the domraffler
 * contest (https://github.com/domcode/rafflers)
 *
 * The whitespace program reads the input, decides which line
 * to print out, and does so.
 *
 * It doesn't quite fulfil the rules because Whitespace has no
 * means to read the filesystem or generate random numbers.
 * But it's close.
 *
 * This is not purporting to be any good.  It's my learning
 * by doing.  It's rather fun, though, trying to write a
 * program in this way.
 *
 */

require_once __DIR__ . '/phpwhitespace/src/PHPWhiteSpace.php';

$ws = new mattp\PHPWhiteSpace();


$start_heap_position_for_characters = 2;
$ws->push($start_heap_position_for_characters);
$ws->duplicate();

// initialise the number of characters counter
$ws->push(1); // we're storing it in heap at position 1
$ws->push(0);
$ws->store();

/**
 *
 * Read from input until it finishes.
 *
 * We keep read_character-ing until we get a 0.
 * Characters are put in the heap starting at position 1.
 *
 * Position 0 is used to count the number of new lines
 * Position 1 is the number of characters
 *
 */
$ws->label('read');

    // get the next character
    $ws->read_character();
    // now we need that character on the stack (it's in the heap atm)
    // so we can jump out if it was 0
    // retrieving leaves the value in the heap

    // copy the top of the stack so we can retrieve it
    $ws->duplicate();
    $ws->retrieve();
    // top of the stack is now the last read character
    // if it's zero we'll jump now
    $ws->jumpz('writeout'); // jumpz pops the value off the stack

    $ws->duplicate();
    $ws->retrieve();
    $ws->call('check_for_newline');


    // add 1 to the number of characters counter
    $ws->push(1);
    $ws->duplicate();
    $ws->retrieve();
    $ws->push(1);
    $ws->add();
    $ws->store();


    // increment the bottom of the stack, which is the pointer to the
    // location on the heap where the next char should go
    $ws->push(1);
    $ws->add();
    // And duplicate, so we keep our counter on the bottom,
    // and this is the next location for a character
    $ws->duplicate();

    // Now read the next character
$ws->jump('read');


/**
 *
 * Checks for newline character (10) and increments counter if so
 *
 */
$ws->label('check_for_newline');

    // ok, it wasn't a 0 = end of file. Maybe it was a new line?

    // newline = 10, so subtract 10 and see if we're at zero:
    $ws->push(10);
    $ws->subtract();

    // if zero (ie last character was 10 == newline), jump to increment counter
    $ws->jumpz('increment_newline_counter');
    // else we're done here
    $ws->jump('finish_check_for_newline');


        /* Adds one to the counter at position 0 of the heap */
        $ws->label('increment_newline_counter');
            // get the current value from the heap:
            $ws->push(0);
            $ws->retrieve();
            // add one
            $ws->push(1);
            $ws->add();
            // put it back in the heap at 0
            $ws->push(0);
            $ws->swap();
            $ws->store();


    $ws->label('finish_check_for_newline');
$ws->return();


/**
 * Decide which line to print out
 */
$ws->label('pick_a_line');
    // 'randomness' is not at all really.
    // we have number of lines in heap position 0
    // and number of characters in heap position 1
    // we'll also use a random seed, generated via http://xkcd.com/221/
    $ws->push(1);
    $ws->retrieve();
    $ws->push(4); // our random number
    $ws->add();
    $ws->push(0);
    $ws->retrieve();
    $ws->modulo(); // top of the stack now contains our randomly chosen line (0-based)

$ws->return();


/**
 *
 * Checks if value at heap 0 is the same as heap 1
 *
 * Puts 0 on the top of the stack if they are the same,
 * something else (the difference) otherwise
 *
 */
$ws->label('heap0_eq_heap1');

    $ws->push(0);
    $ws->retrieve();
    $ws->push(1);
    $ws->retrieve();
    $ws->subtract();

$ws->return();



/**
 *
 * Writes the contents of the heap we read in.
 *
 * We start writing when we get to the
 *
 */
$ws->label('writeout');

    // if there were no characters, we can finish now
    $ws->jumpz('theend');

    // think of a line to print:
    $ws->call('pick_a_line');
    // we can store it in heap position 1 now, we don't need that any more
    $ws->push(1);
    $ws->swap();
    $ws->store();

    // and we'll use heap position 0 now as the line counter,
    // so lets reset it
    $ws->push(0);
    $ws->push(0);
    $ws->store();

    // This is the character we start from (ie the position in the heap)
    $ws->push($start_heap_position_for_characters);
    $ws->duplicate();


    $ws->label('writechar');

        // This is the next letter from the heap:
        $ws->retrieve();

        // if it's a zero we can finish:
        $ws->duplicate(); // need to duplicate because jumpz pops
        $ws->jumpz('theend');


        // let's see if it's a newline, and increment if so
        $ws->duplicate();
        $ws->call('check_for_newline');

        // now we need to check whether our line counter (at heap 0)
        // is the same as our random line (at heap 1)
        $ws->call('heap0_eq_heap1'); // this puts 0 on the stack if they are the same
        $ws->jumpz('write_next_character');  // this pops the 0 off the stack

        $ws->discard();  // this is the diff between heap0 and heap1
        $ws->jump('continue_to_next_character');


        $ws->label('write_next_character');
            $ws->write_character();

        $ws->label('continue_to_next_character');


            // increment the 'character we're on' counter
            $ws->push(1);
            $ws->add();
            $ws->duplicate();

    $ws->jump('writechar');


/**
 * All finished
 */
$ws->label('theend');





// Get it as whitespace:
$code = $ws->export();



file_put_contents('domraffler.ws', $code);
