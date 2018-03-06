If you have `go` installed, you can simply type `./install.sh` and you're good to go.

You can also use the docker file.

```
docker build -t rpkamp-go-raffler .
docker run -i -t -v <path to raffler files>:/var/names.txt rpkamp-go-raffler /var/data/<raffle file>
```

eg

```
docker run -i -t -v /home/rpkamp/names.txt:/var/names.txt rpkamp-go-raffler /var/data/raffler.txt
```

The Docker container will open the file `/var/names.txt` as input for the raffler.
