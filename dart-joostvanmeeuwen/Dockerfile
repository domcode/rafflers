FROM google/dart

WORKDIR /var/app

ADD pubspec.* /var/app/
RUN pub get
ADD . /var/app
RUN pub get --offline

CMD []
ENTRYPOINT ["/usr/bin/dart", "main.dart", "/var/names.txt"]