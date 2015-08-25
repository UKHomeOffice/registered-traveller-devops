#!/bin/bash -ex

function fail() {
  echo "Failed: $@"
  exit 1
}

DATE=`date "+%Y%m%d_%H%M"`

rm -rf fpm/*
mkdir -p fpm/var/lib/clamav

wget http://database.clamav.net/main.cvd -P fpm/var/lib/clamav || fail "Failed to download cvd"
wget http://database.clamav.net/daily.cvd -P fpm/var/lib/clamav || fail "Failed to download cvd"
wget http://database.clamav.net/bytecode.cvd -P fpm/var/lib/clamav || fail "Failed to download cvd"

fpm -C fpm -t rpm -s dir \
    -p NAME-VERSION.ARCH.TYPE \
    -n clam-av-definitions -v "$DATE" -a all . \
    || fail "Failed to build rpm"
