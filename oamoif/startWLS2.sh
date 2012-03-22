
source ~/scripts/env.sh

echo "This script will run for some time..."
nohup $IDM_DOMAIN/startWebLogic.sh &>/dev/null </dev/null &
sleep 60
echo "WLS Console started"
