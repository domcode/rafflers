#!/usr/bin/env php
<?php
// This is from igorw's whitespace-php repo, except
// that the stty -icanon gives an error if you pipe things
// into it.
require __DIR__.'/whitespace-php/src/whitespace.php';

use igorw\whitespace as w;

//system("stty -icanon");

if ($argc <= 1) {
    echo "Usage: bin/interpreter filename.ws\n";
    exit(1);
}

$filename = $argv[1];
$input = str_split(preg_replace('/[^\\t\\n ]/', '', file_get_contents($filename)));

$options = [
    // 'debug' => true,
];

w\evaluate(w\parse($input), $options);

