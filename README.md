# Readme
This repository provides examples on how to use backup/restore tool for
Greenplum.

[![Build Status](https://travis-ci.org/kongyew/greenplum-gphdfs-examples.svg?branch=master)](https://travis-ci.org/kongyew/greenplum-gphdfs-examples)

# Use Case
1. [Learn how to use gpbackup and gprestore](#usecase1/README.MD)
2. [Learn how to use S3 storage plugin with gpbackup and gprestore](#usecase2/README.MD)

## Use gpbackup and gprestore
Now, you can run parallel backup solution for Greenplum. gpbackup and gprestore are designed to improve the performance, functionality, and reliability of backups as compared to gpcrondump and gpdbrestore.

### gpbackup
gpbackup utilizes ACCESS SHARE locks at the individual table level, instead of EXCLUSIVE locks on the pg_class catalog table.

 This enables you to execute DML statements during the backup, such as CREATE, ALTER, DROP, and TRUNCATE operations, as long as those operations do not target the current backup set.

 Therefore, you can quickly run parallel backup to ensure your data is safely protected.

For more details,[see this readme](#usecase1/README.MD)

** GPBackup **
![alt text](usecase1/images/gpbackup.png "Running gpbackup")

** GPbackup and GPrestore **
![alt text](usecase1/images/gpbackup_and_gprestore.png "Running gpbackup and gprestore")


## Use S3 storage plugin with gpbackup and gprestore
Now, you can store your backup files on Amazon Simple Storage Service (Amazon S3) location.

Amazon S3 provides secure, durable, highly-scalable object storage.

** Warning:** The S3 storage plugin for gpbackup and gprestore is an experimental feature is not intended for use in a production environment. Experimental features are subject to change without notice in future releases.
[Learn how to use gpbackup and gprestore](#usecase2/README.MD)

** GPBackup **
![alt text](usecase1/images/gpbackup.png "Running gpbackup")



# Reference:
## Greenplum
The Greenplum Database (GPDB) is an advanced, fully featured, open source data warehouse. It provides powerful and rapid analytics on petabyte scale data volumes. Uniquely geared toward big data analytics, Greenplum Database is powered by the world’s most advanced cost-based query optimizer delivering high analytical query performance on large data volumes.
[Greenplum](https://greenplum.org)
[Pivotal Greenplum](https://pivotal.io/pivotal-greenplum)
