#!/bin/bash

set -e

current=`pwd`

cd `dirname $0`

. ./setEnv.sh



#psql -h ${GREENPLUM_HOST} -U ${GREENPLUM_USER} -d ${POSTGRES_DB} -c ""

cd $current
