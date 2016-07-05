<?php

$filename = !empty($argv[1]) && is_readable($argv[1]) ? realpath($argv[1]) : '';
if (empty($filename)) {
    die('please use `php test.php path_to_file`');
}

$d = new DomCode();
foreach (array_filter(file($filename)) as $name) {
    $d->addname($name);
}
echo $d->raffle().PHP_EOL;
