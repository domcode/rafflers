FROM nixos/nix
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
COPY ./run.sh /run.sh
COPY ./raffle.apl /raffle.apl
CMD /run.sh
