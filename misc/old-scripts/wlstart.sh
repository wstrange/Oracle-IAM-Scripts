#!/bin/bash
# Start up script for a weblogic admin domain and associated service domains
# This is meant for demos and interactive usage 
# A new gnome-terminal will be launched to show the output. You need
# X running
#
# Usage: wlstart.sh domain servers..
# Example: wlstart.sh IDMDomain wls_oif1


# Set your domain home
DOMAIN_HOME=/oracle/Middleware/user_projects/domains


die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -gt 1 ] || die "Usage: wlstart.sh domain servers..."

domain=$1
shift

echo "Starting Admin server for $domain"
cmd=$DOMAIN_HOME/$domain/startWebLogic.sh

[ -x $cmd ] || die "$cmd not found. Does the domain exist?"

gnome-terminal --window-with-profile=weblogic -t "Admin Domain $domain" -e "$cmd"

echo "Sleeping a (long) while to give the Admin server a chance to start up..."

sleep 90

while (( "$#")); do

echo starting managed server $1

cmd="$DOMAIN_HOME/$domain/bin/startManagedWebLogic.sh $1"
# Echo command -in case we want to cut n paste it later
echo $cmd 

gnome-terminal --window-with-profile=weblogic -t $1 -e "$cmd"
sleep 30


shift
done
