#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


export POSTGRES_HOST=localhost
export POSTGRES_USER=gpadmin
export POSTGRES_DB=sample_db
export POSTGRES_DB_PWD=pivotal
export PGPASSWORD=${POSTGRES_DB_PWD}

# Greenplum
export GREENPLUM_HOST=localhost
export GREENPLUM_USER=gpadmin
export GREENPLUM_DB=gpadmin #
export GREENPLUM_DB_PWD=pivotal
export PGPASSWORD=${GREENPLUM_DB_PWD}
