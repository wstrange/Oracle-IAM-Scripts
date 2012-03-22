#!/bin/sh
# Configure the fedlet

# remove the target
rm -fr ~/fedlet.old
mv ~/fedlet ~/fedlet.old
rm /var/tmp/metadata*

# Get the IDP meta data fresh from OIF
(cd /var/tmp; wget http://localhost:7777/fed/idp/metadata )

# Run the fedlet config process
cd ~/fedlet-base/java
java -classpath fedwar/WEB-INF/lib/opensso-sharedlib.jar:fedwar/WEB-INF/lib/openfedlib.jar:install/lib/configurefedlet.jar oracle.security.fed.fedlet.install.ConfigureFedlet  <<EOF
/home/oracle/fedlet-base
http://fedlethost:8080/fedletsample
fedletsp
1
Oracle123
Oracle123
Oracle123
Oracle123
1
/var/tmp/metadata
1
/home/oracle
EOF

