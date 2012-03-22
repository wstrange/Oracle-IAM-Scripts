echo "This script will run for some time..."
source ~/scripts/env.sh
nohup $IDM_DOMAIN/bin/startManagedWebLogic.sh wls_ods1 &>/dev/null </dev/null &
sleep 60
echo "ODSM Console started"
