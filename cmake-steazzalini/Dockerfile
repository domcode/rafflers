FROM afgreen/alpine-cmake

RUN mkdir -p /var/app
WORKDIR /var/app
COPY CMakeLists.txt /var/app

ENTRYPOINT ["cmake", "-DNAMES_PATH=/var/names.txt", "."]
