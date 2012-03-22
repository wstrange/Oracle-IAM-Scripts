#!/bin/sh
oam.sh
echo "sleeping a while -- please wait...."
sleep 90
/oracle/Middleware/asinst_1/bin/opmnctl startall
echo "start middleware ....sleeping a while please wait...."
sleep 60
oif.sh
echo "start oif ..... sleeping a while please wait...."
sleep 30
tomcat.sh 

echo "done"


