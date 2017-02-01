# Domcode Raffler in Clojure

## Building

    docker build -t borkdude/domcode-raffler .

## Running

Place the list of names in `/tmp/names/current` and then run:

    docker run -v /tmp/names:/var/names borkdude/domcode-raffler
