FROM nacyot/pascal-fp_compiler:apt

RUN mkdir -p /app
COPY raffler.p /app/

RUN chmod +x /app/raffler.p
RUN pc /app/raffler.p

WORKDIR /app
CMD ["./raffler", "/var/names.txt"]
