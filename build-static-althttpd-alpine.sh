
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# althttpd
cd $WORKSPACE
aa=$(curl -sL https://sqlite.org/althttpd/info/tip | grep Check-in | rg -Po 'Check-in\ \[\K[0-9a-z]+' | head -n 1 )
curl -sL https://sqlite.org/althttpd/tarball/$aa/althttpd-$aa.tar.gz | tar xv --gzip
cd althttpd-$aa
make static-althttpsd
mv static-althttpsd althttpd
tar vcJf ./althttpd-alpine.tar.xz althttpd

mv ./althttpd-alpine.tar.xz /work/artifact/
