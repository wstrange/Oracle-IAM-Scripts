
source ~/scripts/env.sh
echo "This script will run for some time..."
nohup $OAM_DOMAIN/startWebLogic.sh &>/dev/null </dev/null &
sleep 60
echo "WLS Console started"
