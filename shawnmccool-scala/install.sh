#!/bin/bash

wget http://downloads.typesafe.com/scala/2.11.5/scala-2.11.5.tgz
tar -zxvf ./scala-2.11.5.tgz
rm ./scala-2.11.5.tgz

echo -e "\n\nNow just run: ./scala-2.11.5/bin/scala raffler.scala <namefile>"
