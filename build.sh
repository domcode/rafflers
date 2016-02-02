#!/usr/bin/env bash
set -e

docker build -t shawnmccool_scala_raffler shawnmccool-scala
docker build -t basbl_zsh_raffler basbl-zsh
docker build -t lucasvanlierop_cobol_raffler lucasvanlierop-cobol
docker build -t rjkip_elixir_raffler rjkip-elixir
docker build -t sgoettschkes_haskell_raffler sgoettschkes-haskell
