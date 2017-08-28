[![Build Status](https://travis-ci.org/domcode/rafflers.svg?branch=master)](https://travis-ci.org/domcode/rafflers)

# rafflers
A collection of fun, funky, esoteric rafflers

## Can I submit one?
Yes! Everyone! Even if you're not a member of DomCode. Even if it's already implemented in a language. Be creative. Have fun!

## How does it work?
It's easy! Just create a directory in the top level for your raffler.

Each raffler should accept a filename as the first CLI argument. The file will contain a line-delimited list of names, from which the raffler should echo a single random name from. See the example_names file for an example of the format. The file may contain a trailing newline!

You can write it in any language. The weirder the better. If you like insane over engineering, do so! If you like to do it the way you've been telling your junior colleagues not to, go ahead!

## Getting Merged Quickly
- Please supply a Dockerfile so we do not have to install al these weird stuff on our systems directly :-P
- Wacky GIFs aren't required in your PR but are encouraged (see YoloSR-2).

## Dockerized rafflers

 *Note that Dockerize rafflers receive `/var/names.txt` via the [`raffle.sh`](./raffle.sh) script*

### Dockerfile example:
```
# Choose a base image you like
FROM java:jdk-alpine

# Copy you raffler code to the image
RUN mkdir -p /var/app
COPY src /var/app
WORKDIR /var/app

# Compile (if needed)
RUN javac -g org/domcode/talk/raffler/annaffler/application/Annaffler.java

# Run raffler
CMD ["java", "org/domcode/talk/raffler/annaffler/application/Annaffler", "/var/names.txt"]
```

### Perform a raffle using a random Dockerized raffler

```shell-session
$ # make rebuild
$ make raffle NAMES=/tmp/your-names-file
```

### Test that Dockerized rafflers work

```shell-session
$ make test                         # Tests all rafflers
$ make test RAFFLER=remyhonig-elisp # Tests only the raffler in ./remyhonig-elisp
```
