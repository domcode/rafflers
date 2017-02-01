# Domcode Raffler in ClojureScript on NodeJS via Lumo

## Building

    docker build -t borkdude/domcode-raffler-cljs-node-lumo .

## Running with Docker

Place the list of names in `/tmp/names/current` and then run:

    docker run -v /tmp/names:/var/names borkdude/domcode-raffler-cljs-node-lumo

## Running without Docker

- Install NodeJS
- Run `npm install`
- Run `./run.sh /tmp/names/current`
