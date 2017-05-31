FROM python:3-alpine
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY raffler.py /var/app/raffler.py
WORKDIR /var/app

# Run raffler
CMD ["python", "/var/app/raffler.py", "/var/names.txt"]
