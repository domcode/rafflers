FROM hseeberger/scala-sbt
MAINTAINER michiel@touchdownconsulting.nl

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app/
WORKDIR /var/app

# Build
RUN sbt assembly

# Run raffler
CMD java -jar /var/app/target/scala-2.11/raffler-assembly-1.0.jar /var/names.txt
