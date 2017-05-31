# Domcode Raffler in Clojure

## Building

    docker build -t borkdude/domcode-raffler-clj .

## Running

Place the list of names in `/tmp/names.txt` and then run:

    docker run -v /tmp/names.txt:/var/names.txt borkdude/domcode-raffler-clj
