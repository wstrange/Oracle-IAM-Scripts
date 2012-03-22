#!/bin/sh

# this script does a few things:
# 1 - checks to make sure you have a real name other than localhost.localdomain
# 2 - creates the updatehosts script
# 3 - registers the script via chkconfig
# 4 - runs the script

. /etc/sysconfig/network

if [ "$HOSTNAME" == "localhost.localdomain" ]; then
    echo "You have to update /etc/sysconfig/network to assign this machine a real host name"
    echo "opmn will not run if you leave it as localhost.localdomain"
    exit 1
fi

# check to see if they've rebooted or otherwise reset the hostname since editing the file
if [ "$HOSTNAME" != "`hostname`" ]; then
    echo "Did you reboot or reset your networking after editing /etc/sysconfig/network?"
    echo "/bin/hostname says your host name is `hostname`"
    echo "\$HOSTNAME     says your host name is $HOSTNAME"
    exit 1
fi


# now create the script
cat > /etc/init.d/updatehosts <<EOF
#!/bin/sh
#
# updatehosts       Update the hosts file properly
#
# chkconfig: 2345 11 90
# description: Updates your /etc/hosts file to associate the host name with the\\
#              IP address at boot time.
#
### BEGIN INIT INFO
# Provides: \$network
### END INIT INFO


start() {
    makebackup
    updatehostsfile
    cleanup
}

makebackup() {

    # first things first - make a backup of /etc/hosts
    BACKUPFILENAME=/etc/hosts.bak.\`basename \$0\`
    if [ ! -e \$BACKUPFILENAME ]; then
	echo "Backing up /etc/hosts to \$BACKUPFILENAME"
	cp -a /etc/hosts \$BACKUPFILENAME
    fi
}

updatehostsfile() {
    TEMPFILE=/etc/hosts.\$\$
    
    # one of the funny things about the hostname command is that for it to work the host MUST
    # already be preesent in /etc/hosts
    # so this won't work:
    #HOSTNAME=\`hostname -f\`
    #SHORTHOSTNAME=\`hostname -s\`

    # so to get around that problem we pick up HOSTNAME from the /etc/sysconfig/network file
    . /etc/sysconfig/network
    # and then get SHORTHOSTNAME by truncating HOSTNAME at the first dot
    SHORTHOSTNAME=\`echo \$HOSTNAME | sed -e 's/\\..*//'\`
    
    
    # pick up the CURRENT IP address
    IPADDRESS=\`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print \$1}'\`

    echo "Hostname: \$HOSTNAME"
    echo "Short hostname: \$SHORTHOSTNAME"
    echo "IP Address: \$IPADDRESS"

    # before going further make sure we actually got both a hostname and an IP address
    if [ "\$HOSTNAME" == "" ]; then
	echo "Unable to determine hostname"
	exit 1
    fi
    
    if [ "\$SHORTHOSTNAME" == "" ]; then
	echo "Unable to determine short hostname"
	exit 1
    fi
    
    if [ "\$IPADDRESS" == "" ]; then
	echo "Unable to determine IP Address"
	exit 1
    fi


    # there are two different possibilities for the contents of /etc/hosts
    # 1: a line with localhost AND this host name associated with 127.0.0.1
    # 2: one line with localhost and one with this host name

    LOCALHOSTLINE=\`grep ^127.0.0.1 /etc/hosts\`
    # this could be better:
    HOSTLINE=\`grep \$HOSTNAME /etc/hosts | grep -v ^\\#\`

    #echo Localhost line: \$LOCALHOSTLINE
    #echo Host line: \$HOSTLINE

    if [ "\$LOCALHOSTLINE" == "" ]; then
	echo "Unable to find localhost line in /etc/hosts!"
	exit 2;
    fi
    
    # we ignore this issue here and address it later
    #if [ "\$HOSTLINE" == "" ]; then
    #    echo "Unable to find host line in /etc/hosts!"
    #    exit 2;
    #fi
    
    if [[ \$LOCALHOSTLINE == *\$HOSTNAME* ]]; then
        #echo Localhost line contains \$HOSTNAME
	#echo -e "#\\n# File updated by \$0\\n#\\n" >> \$TEMPFILE

        # in this case we need to comment out this line and add a 127.0.0.1 = localhost line
        # then add another line for our host name
	rm -f /etc/hosts.\$\$
		
        # I am going to comment out the existing line rather than removing it
	sed -e "s/\$LOCALHOSTLINE/#\$LOCALHOSTLINE/" /etc/hosts >> \$TEMPFILE
    
	echo -e "\\n# Inserted by \$0" >> \$TEMPFILE
	echo -e "127.0.0.1\\t\\tlocalhost.localdomain localhost" >> \$TEMPFILE
	echo -e "\$IPADDRESS\\t\\t\$HOSTNAME \$SHORTHOSTNAME" >> \$TEMPFILE
    else
	echo Localhost line does NOT contain \$HOSTNAME

	# we deal with the case of the host not being present in the file here
	if [ "\$HOSTLINE" == "" ]; then
	    echo "Hosts file does not contain entry for \$HOSTNAME / \$SHORTHOSTNAME"
	    cat /etc/hosts

	    cat /etc/hosts >> \$TEMPFILE
	    # then add on the line for the hostname
	    echo -e "\$IPADDRESS\\t\\t\$HOSTNAME \$SHORTHOSTNAME" >> \$TEMPFILE

	else
	    # in this case we need to check to see if the existing host line has the right IP address

	    EXISTING_IP=\`grep \$HOSTNAME /etc/hosts | grep -v ^\\# | awk '{print \$1}'\`
	    
	    if [ "\$EXISTING_IP" == "\$IPADDRESS" ]; then
		echo "IP address unchanged."
	    else
		echo "IP address has changed. Updating file."
		
		NEWHOSTLINE=\`echo -e "\$IPADDRESS\\t\\t\$HOSTNAME \$SHORTHOSTNAME"\`
		sed -e "s/\$HOSTLINE/\$NEWHOSTLINE/" /etc/hosts >> \$TEMPFILE
	    fi
	fi
    fi

    if [ ! -e \$TEMPFILE ]; then
	echo "Hosts file unchanged."
    else
	echo "Hosts file updated. New /etc/hosts file:"
	echo "===================="
	cat \$TEMPFILE
	
        # sanity checks go here
	mv -f \$TEMPFILE /etc/hosts
    fi
}

cleanup() {
    # just in case...
    rm -f \$TEMPFILE
}

case \$1 in
    start)
        start
        exit 0
    ;;
    stop)
        echo "Nothing to do"
	exit 0
    ;;

    status)
        cat /etc/hosts
	exit 0
    ;;

    *)
    
    echo \$"Usage: \$prog {start|stop|status}"
    exit 3
esac
EOF

chmod a+rx /etc/init.d/updatehosts

chkconfig --add updatehosts
chkconfig --list updatehosts
/etc/init.d/updatehosts start
