/app/Oracle/product/11.2.0/dbhome_1/bin/lsnrctl start
sleep 10
/app/Oracle/product/11.2.0/dbhome_1/bin/sqlplus "/ as sysdba" <<EOF
startup
select trim(instance_name)||' is '||decode(status, 'STARTED', 'NOMOUNT', status) ||' on '||host_Name "INSTANCE_STATUS" from v\$instance;
exit
EOF
