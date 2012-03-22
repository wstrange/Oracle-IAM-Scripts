/app/Oracle/product/11.2.0/dbhome_1/bin/sqlplus "/ as sysdba" <<EOF
shutdown immediate
exit
EOF
/app/Oracle/product/11.2.0/dbhome_1/bin/lsnrctl stop
