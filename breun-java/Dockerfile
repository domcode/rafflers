FROM openjdk:8u121-alpine
COPY Raffler.java /tmp/
WORKDIR /tmp
RUN javac Raffler.java
ENTRYPOINT ["java", "Raffler", "/var/names.txt"]
