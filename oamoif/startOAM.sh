echo "This script will run for some time..."
source ~/scripts/env.sh
nohup $OAM_DOMAIN/bin/startManagedWebLogic.sh oam_server1 &>/dev/null </dev/null &
sleep 60
echo "OAM Server started"
