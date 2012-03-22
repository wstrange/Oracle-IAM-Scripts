#!/bin/sh


. osver.sh

if [ "$OS_VER" == "5" ]; then
    echo "On OEL 5 oracle-validated already took care of all of this stuff."

elif [ "$OS_VER" == "6" ]; then
    yum -y install libgcc.i686  compat-libstdc++-33.i686
    yum -y install libXext.i686
    yum -y install libXtst.i686
fi

