#!/bin/sh


# need to determine whether we're on OEL5 or OEL6
. osver.sh

if [ "$OS_VER" == "5" ]; then
    echo The oracle-validated package takes care of all of this for you

elif [ $"$OS_VER" == "6" ]; then
    cat >> /etc/sysctl.conf <<EOF
# from my scripts for Oracle
kernel.shmall = 2097152
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
kernel.shmmax = 4294967295
fs.file-max = 6815744
net.ipv4.ip_local_port_range = 1024     65500
net.core.rmem_default = 4194304
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
#net.core.wmem_max = 262144
net.core.wmem_max = 1048576
fs.aio-max-nr = 1048576
EOF

    /sbin/sysctl -p



    cat >> /etc/security/limits.conf <<EOF
oracle           soft    nproc   2047
oracle           hard    nproc   16384
oracle           soft    nofile  1024
oracle           hard    nofile  65536
EOF

    # need to check to see if pam_limits.so is already in /etc/pam.d/login
    grep -l pam_limits.so /etc/pam.d/login > /dev/null 2>&1
    if [ "$?" -ne "0" ]; then
	echo "pam_limits not in /etc/pam.d/login. Adding it"
	
        #echo "session    required     /lib/security/pam_limits.so" >> /etc/pam.d/login
	echo "session    required     pam_limits.so" >> /etc/pam.d/login
    fi

    echo Log out and back in to pick up the new limits
fi

