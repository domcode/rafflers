#!/bin/bash

export PATH=$PATH:/home/vagrant/haxe-3.1.3
export HAXE_STD_PATH=/home/vagrant/haxe-3.1.3/std

cd /vagrant
haxe -main Raffler -php raffler-php

