
#! /bin/bash

set -e

ALTHTTPD_BUILD_OS=$(lsb_release -is |  tr '[:upper:]' '[:lower:]')
HOST_OS_RAW=$(uname -s)
HOST_ARCH_RAW=$(uname -m)

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# althttpd
cd $WORKSPACE
aa=$(curl -sL https://sqlite.org/althttpd/info/tip | rg Check-in | rg -Po 'Check-in\ \[\K[0-9a-z]+' | head -n 1 )
curl -sL https://sqlite.org/althttpd/tarball/$aa/althttpd-$aa.tar.gz | tar xv --gzip
cd althttpd-$aa
make static-althttpsd
mv static-althttpsd althttpd
tar vcJf ./althttpd.tar.xz althttpd

mv ./althttpd-${ALTHTTPD_BUILD_OS}-${HOST_ARCH_RAW}.tar.xz /work/artifact/
./althttpd --version
