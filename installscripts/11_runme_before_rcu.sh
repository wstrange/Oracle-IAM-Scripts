#!/bin/sh

ORAENV_ASK=NO
ORACLE_SID=orcl
#.oracledemo.com
export ORAENV_ASK
export ORACLE_SID

. /usr/local/bin/oraenv

cat | sqlplus sys/ABcd1234@orcl as sysdba <<EOF
alter system set processes=500 scope=spfile;
alter system set open_cursors=800 scope=spfile;
shutdown immediate
EOF

echo sleeping 5 seconds
sleep 5

echo starting DB up again
/etc/init.d/oracle start

#cat | sqlplus sys/ABcd1234 as sysdba <<EOF
#startup
#EOF
