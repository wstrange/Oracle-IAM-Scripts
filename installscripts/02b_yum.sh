#!/bin/sh

. osver.sh

cd /etc/yum.repos.d

if [ "$OS_VER" == "5" ]; then
    wget -nc http://public-yum.oracle.com/public-yum-el5.repo
elif [ "$OS_VER" == "6" ]; then
    wget -nc http://public-yum.oracle.com/public-yum-ol6.repo
else
    echo Edit script
fi

echo Edit `ls /etc/yum.repos.d/` to enable the repository for this version of OEL.
