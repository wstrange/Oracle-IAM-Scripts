#!/bin/bash
# Start opmn procs

source ~/scripts/env.sh

$MW_HOME/asinst_1/bin/opmnctl start
sleep 10
$MW_HOME/asinst_1/bin/opmnctl startproc ias-component=ohs1
sleep 10
$MW_HOME/asinst_1/bin/opmnctl startproc ias-component=ovd1
sleep 10
$MW_HOME/asinst_1/bin/opmnctl startproc ias-component=oid1
sleep 10
$MW_HOME/asinst_1/bin/opmnctl startproc ias-component=EMAGENT
sleep 10
$MW_HOME/asinst_1/bin/opmnctl status -l
