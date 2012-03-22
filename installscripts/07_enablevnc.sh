#!/bin/sh

if [ -e /etc/sysconfig/vncservers.bak ]; then
    echo /etc/hsysconfig/vncservers already exists
    ls -l /etc/sysconfig/vncservers*
    exit
fi

cp /etc/sysconfig/vncservers /etc/sysconfig/vncservers.bak

cat >> /etc/sysconfig/vncservers <<EOF

VNCSERVERS="1:oracle"
VNCSERVERARGS[1]="-geometry 1024x768"
EOF

chkconfig --level 35 vncserver on
chkconfig --list vncserver

service vncserver start


# now add it to avahi if it's installed
if [ -d /etc/avahi/services ]; then 
    echo Avahi seems to be installed.
    if [ -e /etc/avahi/services/rfb.service ]; then
	echo /etc/avahi/services/rfb.service already exists
    else
	cat > /etc/avahi/services/rfb.service <<EOF
<?xml version="1.0" standalone='no'?>  
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">  
<service-group>  
  <name replace-wildcards="yes">%h</name>  
  <service>  
    <type>_rfb._tcp</type>  
    <port>5901</port>  
  </service>  
</service-group>  
EOF
    fi
    service avahi-daemon reload
fi
