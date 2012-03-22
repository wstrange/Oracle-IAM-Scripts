

source ~/scripts/env.sh
$MW_HOME/asinst_1/bin/opmnctl stopproc ias-component=ohs2
sleep 10
$MW_HOME/asinst_1/bin/opmnctl status
