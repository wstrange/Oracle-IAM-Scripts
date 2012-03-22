#!/bin/bash

# Script to finish up webgate install
# You WILL need to edit this for your environment
source ~/scripts/env.sh
WT=$MW_HOME/Oracle_WT1
WG=$MW_HOME/Oracle_OAMWebGate1
INSTANCE=$WT/instances/instance1/config/OHS/ohs1/

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WT/lib

cd $WG/webgate/ohs/tools/deployWebGate

./deployWebGateInstance.sh  -oh $WG -w $INSTANCE

cd $MW_HOME/webgate/ohs/tools/setup/InstallTools

./EditHttpConf -oh $WG -w $INSTANCE

echo "Copy your OAM config files ... example:"
echo  cp $MW_HOME/user_projects/domains/OAM/output/test.oracleads.com/*  $INSTANCE/webgate/config
