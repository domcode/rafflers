FROM cromo/squirrel

RUN mkdir -p /app
COPY raffler.sq /app/
RUN chmod +x /app/raffler.sq

CMD ["sq", "/app/raffler.sq", "/var/names.txt"]
