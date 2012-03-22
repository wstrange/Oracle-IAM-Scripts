#!/bin/sh

FILE=/etc/selinux/config
BACKUP=$FILE.bak

if [ -e $BACKUP ]; then
    echo $BACKUP already exists
    ls -l $FILE $BACKUP
    exit
fi

mv $FILE $BACKUP
sed -e 's/SELINUX=enforcing/SELINUX=permissive/' $BACKUP > $FILE

if [ -e $BACKUP ]; then
    echo '===================================='
    echo '|           OLD file               |'
    echo '===================================='
    cat $BACKUP
fi

echo '===================================='
echo '|           NEW file               |'
echo '===================================='
cat $FILE
