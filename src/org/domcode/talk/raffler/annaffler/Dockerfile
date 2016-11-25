FROM java:jdk-alpine
MAINTAINER robin@kingsquare.org

# Create working dir
RUN mkdir -p /var/app
COPY Annaffler.java /var/app/Annaffler.java
WORKDIR /var/app

# Compile
RUN javac -g Annaffler.java

# Run raffler
CMD ["java", "Annaffler", "/var/names/current"]
