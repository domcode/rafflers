#!/usr/bin/env bash
set -e

# Note that the rust raffle does not compile yet
#docker build -t frankdejonge_rust_raffler frankdejonge-rust
docker build -t basbl_zsh_raffler basbl-zsh
docker build -t lucasvanlierop_cobol_raffler lucasvanlierop-cobol
docker build -t sgoettschkes_haskell_raffler sgoettschkes-haskell
