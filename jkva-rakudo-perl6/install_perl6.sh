#!/bin/sh

VERSION=rakudo-star-2017.07

wget https://rakudo.perl6.org/downloads/star/${VERSION}.tar.gz
tar xfz ${VERSION}.tar.gz
cd $VERSION
perl Configure.pl --backend=moar --gen-moar
make
# make rakudo-test
# make rakudo-spectest
make install
