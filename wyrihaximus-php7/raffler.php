<?php

echo (function ($array) {
    shuffle($array);
    return $array;
})(array_filter(file(realpath($argv[1]))))[0], PHP_EOL;
