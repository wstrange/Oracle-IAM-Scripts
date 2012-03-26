#!/bin/sh

. osver.sh 

cd /tmp

if [ "$OS_VER" == "5" ]; then
    wget -nc http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
    rpm -ivh epel-release-5-4.noarch.rpm
elif [ "$OS_VER" == "6" ]; then
    wget -nc  http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-5.noarch.rpm
    rpm -ivh epel-release-6-5.noarch.rpm
else
    echo OS Version not recognized
fi

