FROM php:7-alpine
MAINTAINER robin@kingsquare.nl
RUN apk add --no-cache git

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app


# in order not to alter the original install.sh and _not_ use SSH for git, use HTTP here
RUN git clone http://github.com/mathiasverraes/lambdalicious.git && \
    cd lambdalicious && \
    git checkout 6bce3e9dcf02b602c502b09748bc7b47d4af62cb

# Run raffler
ENTRYPOINT ["php", "/var/app/raffler.λ.php", "/var/names.txt"]
