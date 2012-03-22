# this script is intended to be used by the other ones.
# don't run it directly!

# old crappy way
# need to determine whether we're on OEL5 or OEL6
#OSVERSTRING=`cat /etc/redhat-release`
#
#if [ "$OSVERSTRING" == "Red Hat Enterprise Linux Server release 5.6 (Tikanga)" ]; then

# new better (but not perfect) way
OSVERNUM=`lsb_release -r | awk '{print $NF}'`
if [ "$OSVERNUM" == "5.6" ]; then
    echo "Running on version 5 update 6"
    OS_VER=5
    OS_UPDATE=6
else
  echo "Update the osver.sh script please."
fi
