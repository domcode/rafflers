FROM erlang:19-slim
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY raffler.erl /var/app/raffler.erl
WORKDIR /var/app

# Run raffler
CMD ["escript",  "/var/app/raffler.erl", "/var/names.txt"]
