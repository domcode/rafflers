<?php

$domcode = new DomCode();

$names = array_filter(file('/var/names.txt'));
foreach ($names as $name) {
    $domcode->addName($name);
}

echo $domcode->raffle() . PHP_EOL;
