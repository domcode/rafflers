FROM clojure:boot

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN boot build
CMD ["java", "-jar", "target/raffler.jar", "/var/names.txt"]
