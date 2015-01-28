<?php

require_once __DIR__ . '/lambdalicious/src/Verraes/Lambdalicious/load.php';

$winner = pipe(
    @realpath,
    @file_get_contents,
    partial(@explode, "\n"),
    al, // array to list
    filter(@strlen, __),
    random
);

echo $winner($argv[1]) . "\n";

