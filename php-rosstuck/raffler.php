<?php
// Boring first example! :D
$fileName = realpath($argv[1]);

// Split on new lines
$names = explode("\n", file_get_contents($fileName));

// Filter any empty entries resulting from trailing string in our file
$names = array_filter($names);

// Print random name plus an EOL so it wraps on shell
echo $names[array_rand($names)] . PHP_EOL;

