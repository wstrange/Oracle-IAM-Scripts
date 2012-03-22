source ~/scripts/env.sh
echo "This script will run for some time..."
nohup $IDM_DOMAIN/bin/startManagedWebLogic.sh wls_oif1 &>/dev/null </dev/null &
sleep 60
echo "OIF Server started"
