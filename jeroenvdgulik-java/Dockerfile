FROM java:jdk-alpine
MAINTAINER robin@kingsquare.org

# Create working dir
RUN mkdir -p /var/app
COPY Raffler.java /var/app/Raffler.java
WORKDIR /var/app

# Compile
RUN javac -g Raffler.java

# Run raffler
CMD ["java", "Raffler", "/var/names.txt"]
