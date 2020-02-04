#!/usr/bin/env sh
#set -x
DIR=~/Downloads
MIRROR=https://releases.hashicorp.com/vagrant

ripsha()
{
    local ver=$1
    local lshasums=$2
    local arch=$3
    local pkg=$4
    local file=vagrant_${ver}_${arch}.$pkg
    printf "      %s: sha256:%s\n" $pkg `fgrep $file $lshasums | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    local shasums=vagrant_${ver}_SHA256SUMS
    local url=$MIRROR/$ver/$shasums
    local lshasums=$DIR/$shasums

    if [ ! -e $lshasums ];
    then
        wget -q -O $lshasums $url
    fi

    printf "  # %s\n" $url
    printf "  '%s':\n" $ver
    printf "    x86_64:\n"
    ripsha $ver $lshasums x86_64 deb
    ripsha $ver $lshasums x86_64 dmg
    ripsha $ver $lshasums x86_64 rpm
    printf "    i686:\n"
    ripsha $ver $lshasums i686 deb
    ripsha $ver $lshasums i686 rpm
}

dl_ver ${1:-2.2.7}
