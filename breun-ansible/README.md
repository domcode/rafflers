Docker
======

There is an included Dockerfile.

Standalone
==========

Requirements
------------

Ansible (tested on 2.3.0.0).

Run
---

If /var/names/current contains a list of names:

    $ ansible-playbook raffler.yml

If the file is somewhere else, specify its location like this:

    $ ansible-playbook raffler.yml -e file=/tmp/people.txt
