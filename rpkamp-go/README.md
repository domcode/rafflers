If you have `go` installed, you can simply type `./install.sh` and you're good to go.

You can also use the docker file.

```
docker build -t rpkamp-go-raffler .
docker run -i -t -v <path to raffler files>:/var/data rpkamp-go-raffler /var/data/<raffle file>
```

eg

```
docker run -i -t -v /home/rpkamp:/var/data rpkamp-go-raffler /var/data/raffler.txt
```