<?php

declare(strict_types=1);

namespace Php74Raffler;

class Raffler
{
    private bool $loaded = false;
    /** @var array<string> */
    private array $names;

    public function load(string $filename): void
    {
        if (! is_readable($filename)) {
            throw new \RuntimeException("Unable to read from $filename, check the filename and permissions");
        }

        $content = file_get_contents($filename);
        if ($content === false) {
            throw new \RuntimeException("Failure when trying to read from $filename");
        }

        $this->names = array_map(fn($name) => trim($name), explode(PHP_EOL, $content));
        $this->names = array_filter($this->names);
        $this->loaded = true;
    }

    public function pickWinner(): string
    {
        $winner = array_rand($this->names);

        return $this->names[$winner];
    }
}
