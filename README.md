# rafflers
A collection of fun, funky, esoteric rafflers

## How does it work?
It's easy! Just create a directory in the top level for your raffler.

Each raffler should accept a filename as the first CLI argument. The file will contain a line-delimited list of names, from which the raffler should echo a single random name from. See the example_names file for an example of the format.

You can write it in any language (provided you can prove to our hosts that it's not malware). If you've got dependencies, please include a simple install.sh for the debian dependencies.

## Getting Merged Quickly
- Please throw in an install.sh if you're using something besides PHP or Python.
- Wacky GIFs isn't required in your PR standards but is encouraged (see YoloSR-2).
