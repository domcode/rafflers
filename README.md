# rafflers
A collection of fun, funky, esoteric rafflers

## Can I submit one?
Yes! Everyone! Even if you're not a member of DomCode. Even if it's already implemented in a language. Be creative. Have fun!

## How does it work?
It's easy! Just create a directory in the top level for your raffler.

Each raffler should accept a filename as the first CLI argument. The file will contain a line-delimited list of names, from which the raffler should echo a single random name from. See the example_names file for an example of the format.

You can write it in any language. The weirder the better If you like insane over engineering, do so! If you like to do it the way you've been telling your junior colleagues no to, go ahead!

## Getting Merged Quickly
- Please supply a Dockerfile so we do not have to install al these weird stuff on our systems directly :-P 
- Wacky GIFs aren't required in your PR but are encouraged (see YoloSR-2).

## Dockerfile example:
```
FROM ubuntu:15.10 # or a more suitable base container
MAINTAINER yourname@domain.org
ENV LANG C.UTF-8

# Install your dependencies
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y deps-you-require

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Compile raffler (if necessary)
RUN /var/app/compile.sh # everything needed to compile your raffler

# Run raffler
CMD ["/var/app/run.sh"] #everything needed to run your raffler
```

