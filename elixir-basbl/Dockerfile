FROM elixir:1.3-slim
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY raffler.exs /var/app/raffler.exs
WORKDIR /var/app

# Run raffler
CMD ["elixir", "/var/app/raffler.exs", "/var/names.txt"]
