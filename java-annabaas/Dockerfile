FROM java:jdk-alpine
MAINTAINER annabaas@gmail.com

# Create working dir
RUN mkdir -p /var/app
COPY src /var/app
WORKDIR /var/app

# Compile
RUN javac -g org/domcode/talk/raffler/annaffler/application/Annaffler.java

# Run raffler
CMD ["java", "org/domcode/talk/raffler/annaffler/application/Annaffler", "/var/names.txt"]
