FROM python:2-alpine
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["python", "/var/app/raffler.py", "/var/names.txt"]
