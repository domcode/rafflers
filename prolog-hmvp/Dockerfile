# Choose a base image you like
FROM swipl

# Copy you raffler code to the image
RUN mkdir -p /var/app
COPY raffler.pl /var/app
WORKDIR /var/app

# Compile (if needed)
#RUN javac -g org/domcode/talk/raffler/annaffler/application/Annaffler.java

# Run raffler
CMD ["swipl", "-q",  "raffler.pl", "/var/names.txt"]
