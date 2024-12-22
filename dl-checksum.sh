#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://releases.hashicorp.com/vagrant

# https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_SHA256SUMS
# https://releases.hashicorp.com/vagrant/2.3.0/vagrant-2.3.0-1.x86_64.rpm
# https://releases.hashicorp.com/vagrant/2.3.0/vagrant-2.3.0-1.i686.rpm
# https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0-1_amd64.deb
# https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0-1_i686.deb
# https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_darwin_amd64.dmg

pkgfile() {
    local pkg=$1
    local infix1=$2
    local infix2=$3
    local ver=$4
    local patch_suffix=$5
    local arch=$6
    echo "vagrant${infix1}${ver}${patch_suffix}${infix2}${arch}.${pkg}"
}

rpm() {
    local ver=$1
    local patch_suffix=$2
    local arch=$3
    pkgfile rpm "-" "." $ver $patch_suffix $arch
}

deb() {
    local ver=$1
    local patch_suffix=$2
    local arch=$3
    pkgfile deb "_" "_" $ver $patch_suffix $arch
}

ripsha()
{
    local ver=$1
    local lshasums=$2
    local pkg=$3
    local file=$4
    printf "      # %s/%s/%s\n" $MIRROR $ver $file
    printf "      %s: sha256:%s\n" $pkg $(grep $file $lshasums | awk '{print $1}')
}

dl_ver() {
    local major_ver=$1
    local minor_ver=$2
    local patch_ver=$3
    local patch_suffix=$4
    local ver="${major_ver}.${minor_ver}.${patch_ver}"
    local shasums=vagrant_${ver}_SHA256SUMS
    local url=$MIRROR/$ver/$shasums
    local lshasums=$DIR/$shasums

    if [ ! -e $lshasums ];
    then
        curl -sSLf -o $lshasums $url
    fi

    printf "  # %s\n" $url
    printf "  '%s%s':\n" $ver $patch_suffix
    printf "    x86_64:\n"
    ripsha $ver $lshasums deb $(deb $ver -1 amd64)
    ripsha $ver $lshasums rpm $(rpm $ver -1 x86_64)
    printf "    x86_32:\n"
    ripsha $ver $lshasums deb $(deb $ver -1 i686)
    ripsha $ver $lshasums rpm $(rpm $ver -1 i686)
}

dl_ver 2 4 3 -1
