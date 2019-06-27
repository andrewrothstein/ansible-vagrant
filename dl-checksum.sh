#!/usr/bin/env sh
VER=2.2.5
DIR=~/Downloads
SHASUMS=vagrant_${VER}_SHA256SUMS
URL=https://releases.hashicorp.com/vagrant/$VER/$SHASUMS
LSHASUMS=$DIR/$SHASUMS

if [ ! -e $LSHASUMS ]
then
    wget -q -O $LSHASUMS $URL
fi

ripsha()
{
    PLATFORM=$1
    PKG=$2
    FILE=vagrant_${VER}_${PLATFORM}.$PKG
    printf "    %s: sha256:%s\n" $PKG `fgrep $FILE $LSHASUMS | awk '{print $1}'`
}

printf "# %s\n" $URL
printf "'%s':\n" $VER
printf "  x86_64:\n"
ripsha x86_64 deb
ripsha x86_64 dmg
ripsha x86_64 rpm
printf "  i686:\n"
ripsha i686 deb
ripsha i686 rpm


