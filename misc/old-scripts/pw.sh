#!/bin/sh

FBASE=/home/oracle/fedlet-install/java
FEDWAR=$FBASE/fedwar

java -classpath $FEDWAR/WEB-INF/lib/opensso-sharedlib.jar:$FEDWAR/WEB-INF/lib/openfedlib.jar:$FBASE/install/lib/configurefedlet.jar \
-D"com.sun.identity.fedlet.home=/home/oracle/fedlet" \
oracle.security.fed.fedlet.install.ConfigureFedlet -e

