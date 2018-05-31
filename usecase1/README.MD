
# Greenplum
Greenplum Database® is an advanced, fully featured, open source data platform.  It provides powerful and rapid analytics on petabyte scale data volumes.  Uniquely geared toward big data analytics, Greenplum Database is powered by the world’s most advanced cost-based query optimizer delivering high analytical query performance on large data volumes.
<https://greenplum.org>

# Learn how to use gpbackup and gprestore
This [repository](https://github.com/kongyew/greenplum-backup) demonstrates how to use gpbackup and gprestore for Greenplum

# Table of Contents
1. [Pre-requisites](#Pre-requisites)
2. [Start Docker-compose](#Start-Docker-compose)
3. [Use gpbackup](#Use-gpbackup)
4. [Use gprestore](#Use-gprestore)

## Pre-requisites:
- [docker-compose](http://docs.docker.com/compose)
- [GPDB 5.x docker image](https://hub.docker.com/r/kochanpivotal/)

## Start Docker-compose
Once you have cloned this repository, you can run the command  `./runDocker.sh -t usecase1 -c up`, in order to start  Greenplum docker instance.

The assumption: docker and docker-compose are already installed on your machine.

### Run command to start both Greenplum
```
$ ./runDocker.sh -t usecase1 -c up
Recreating gpdbsne ... done
gpdbsne     | /etc/sysconfig/run-parts
gpdbsne     | /usr/bin/run-parts
gpdbsne     | Running /docker-entrypoint.d
gpdbsne     | /docker-entrypoint.d/startInit.sh:
gpdbsne     |
gpdbsne     | init is running
gpdbsne     | /docker-entrypoint.d/startSSH.sh:
```

### How to access Greenplum docker instance:
You can use this command `docker exec -it gpdbsne bin/bash` to access Greenplum docker instance.

For example:
```
$ docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                                                                                             NAMES
22c87a7bc39d        kochanpivotal/gpdb5-pxf      "/docker-entrypoint.…"   4 minutes ago       Up 4 minutes        0.0.0.0:5005->5005/tcp, 0.0.0.0:5010->5010/tcp, 0.0.0.0:5432->5432/tcp, 0.0.0.0:40000-40002->40000-40002/tcp, 0.0.0.0:9022->22/tcp                                                                               gpdbsne

root@gpdbsne:/#
```

## Use gpbackup
Once you have access to Greenplum docker instance, you can backup existing Database.

1. Start GPDB instance:
Use the command 'startGPDB.sh'
```
root@gpdbsne# startGPDB.sh
SSHD isn't running
 * Starting OpenBSD Secure Shell server sshd                             [ OK ]
SSHD is running...
20180419:21:15:09:000094 gpstart:gpdbsne:gpadmin-[INFO]:-Starting gpstart with args: -a
20180419:21:15:09:000094 gpstart:gpdbsne:gpadmin-[INFO]:-Gathering information and validating the environment...
...
20180419:21:15:18:000247 gpstart:gpdbsne:gpadmin-[INFO]:-Have lock file /tmp/.s.PGSQL.5432 and a process running on port 5432
20180419:21:15:18:000247 gpstart:gpdbsne:gpadmin-[ERROR]:-gpstart error: Master instance process running
```
2. Use gpadmin user.
```
[root@gpdbsne /]# su - gpadmin
Last login: Wed May 30 23:51:49 UTC 2018 on pts/0
[gpadmin@gpdbsne ~]$
```
3. Run gpbackup
Use this commands:
```
$ export PGPASSWORD="pivotal"
$ gpbackup --dbname postgres --debug -backup-dir /tmp
```

Result of the backup process:
```
[gpadmin@gpdbsne ~]$ export PGPASSWORD="pivotal"
[gpadmin@gpdbsne ~]$ gpbackup --dbname postgres --debug -backup-dir /tmp
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Starting backup of database postgres
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Creating backup directories
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Backup Timestamp = 20180531174443
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Backup Database = postgres
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Gathering list of tables for backup
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Acquiring ACCESS SHARE locks on tables
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Gathering additional table metadata
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Retrieving column information
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Retrieving partition information
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Retrieving storage information
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Retrieving external table information
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Constructing table definition map
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[WARNING]:-No tables in backup set contain data. Performing metadata-only backup instead.
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Metadata will be written to /tmp/gpseg-1/backups/20180531/20180531174443/gpbackup_20180531174443_metadata.sql
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Writing global database metadata
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TABLESPACE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE DATABASE statement to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing database GUCs to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE RESOURCE QUEUE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE RESOURCE GROUP statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE ROLE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing GRANT ROLE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Global database metadata backup complete
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Writing pre-data metadata
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE SCHEMA statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE EXTENSIONS statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Retrieving function information
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Retrieving type information
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE PROCEDURAL LANGUAGE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TYPE statements for shell types to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TYPE statements for enum types to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE SEQUENCE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE FUNCTION statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TYPE statements for base, composite, and domain types to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TABLE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing ALTER SEQUENCE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE PROTOCOL statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TEXT SEARCH PARSER statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TEXT SEARCH TEMPLATE statements to metadata file
20180531:17:44:43 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TEXT SEARCH DICTIONARY statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TEXT SEARCH CONFIGURATION statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE OPERATOR statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE OPERATOR FAMILY statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE OPERATOR CLASS statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE CONVERSION statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE AGGREGATE statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE CAST statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE VIEW statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing ADD CONSTRAINT statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Pre-data metadata backup complete
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Writing post-data metadata
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE INDEX statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE RULE statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Writing CREATE TRIGGER statements to metadata file
20180531:17:44:44 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Post-data metadata backup complete
20180531:17:44:45 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Found neither /usr/local/greenplum-db/./bin/gp_email_contacts.yaml nor /home/gpadmin/gp_email_contacts.yaml
20180531:17:44:45 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Email containing gpbackup report /tmp/gpseg-1/backups/20180531/20180531174443/gpbackup_20180531174443_report will not be sent
20180531:17:44:45 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Beginning cleanup
20180531:17:44:45 gpbackup:gpadmin:gpdbsne:000509-[DEBUG]:-Cleanup complete
20180531:17:44:45 gpbackup:gpadmin:gpdbsne:000509-[INFO]:-Backup completed successfully
[gpadmin@gpdbsne ~]$
```
4. Verify the backup file is found in the target directory under `/tmp`:
For example:
```
[gpadmin@gpdbsne ~]$ ls -al /tmp/gpseg0
total 12
drwxrwxr-x 3 gpadmin gpadmin 4096 May 31 18:00 .
drwxrwxrwt 1 root    root    4096 May 31 18:00 ..
drwxrwxr-x 3 gpadmin gpadmin 4096 May 31 18:00 backups
[gpadmin@gpdbsne ~]$
```


# Reference:
* [gpbackup](https://gpdb.docs.pivotal.io/580/utility_guide/admin_utilities/gpbackup.html)
* [Greenplum product](https://pivotal.io/pivotal-greenplum)
* [Greenplum documentations](https://https://gpdb.docs.pivotal.io/)
