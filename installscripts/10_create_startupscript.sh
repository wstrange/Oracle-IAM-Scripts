#!/bin/sh

#echo "Don't forget to update /etc/oratab and change the last N to a Y"
echo "Updating /etc/oratab"
cp -p /etc/oratab /etc/oratab.bak
sed -e 's/:N$/:Y/' /etc/oratab.bak > /etc/oratab



echo Creating startup script

cat > /etc/init.d/oracle <<EOF
#!/bin/bash
#
# oracle Init file for starting and stopping
# Oracle Database. Script is valid for 10g and 11g versions.
#
# chkconfig: 345 80 30
# description: Oracle Database startup script

# Source function library.

. /etc/rc.d/init.d/functions

#ORAENV_ASK=NO
#export ORAENV_ASK

#ORACLE_SID=orcl
#export ORACLE_SID
#. /usr/local/bin/oraenv



ORACLE_OWNER="oracle"
ORACLE_HOME="/home/oracle/database/product/11.2.0/dbhome_1"

case "\$1" in
start)
echo -n $"Starting Oracle DB:"
su - \$ORACLE_OWNER -c "\$ORACLE_HOME/bin/dbstart \$ORACLE_HOME"
echo "OK"
;;
stop)
echo -n $"Stopping Oracle DB:"
su - \$ORACLE_OWNER -c "\$ORACLE_HOME/bin/dbshut \$ORACLE_HOME"
echo "OK"
;;
*)
echo $"Usage: \$0 {start|stop}"
esac
EOF

chmod 750 /etc/init.d/oracle

echo "Configuring system to start Oracle database at boot"
/sbin/chkconfig --add oracle --level 0356 
