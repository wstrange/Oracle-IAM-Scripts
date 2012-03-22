#!/bin/sh

# mkdir -p /u01/app/
# chown -R oracle:oinstall /u01/app/
# chmod -R 775 /u01/app/

mkdir /home/oracle/database
chown -R oracle:oinstall /home/oracle/database
chmod -R 775 /home/oracle/database

cat >> /home/oracle/.bash_profile <<EOF
umask 022
ORACLE_BASE=/home/oracle/database
ORACLE_SID=orcl
export ORACLE_BASE ORACLE_SID

EOF

chown oracle.oinstall /home/oracle/.bash_profile

