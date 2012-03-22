source ~/scripts/env.sh

$MW_HOME/asinst_1/bin/opmnctl startproc ias-component=ohs2
sleep 10
$MW_HOME/asinst_1/bin/opmnctl status -l

