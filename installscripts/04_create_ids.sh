#!/bin/sh

/usr/sbin/groupadd oinstall
/usr/sbin/groupadd dba
/usr/sbin/useradd -g oinstall -G dba oracle
echo ABcd1234 | passwd --stdin oracle
