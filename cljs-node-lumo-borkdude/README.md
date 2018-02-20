# Domcode Raffler in ClojureScript on NodeJS via Lumo

## Building

    docker build -t borkdude/domcode-raffler-cljs-node-lumo .

## Running with Docker

Place the list of names in `/tmp/names.txt` and then run:

    docker run -v /tmp/names.txt:/var/names.txt borkdude/domcode-raffler-cljs-node-lumo

## Running without Docker

- Install NodeJS
- Run `npm install`
- Run `./run.sh /tmp/names.txt`
