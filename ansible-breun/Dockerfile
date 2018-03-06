FROM williamyeh/ansible:alpine3
COPY raffler.yml /tmp/
ENTRYPOINT ["ansible-playbook", "/tmp/raffler.yml", "--extra-vars", "file=/var/names.txt"]
