# PGSQL-IO

Steps to build a development environment on AMD (CentOS 7) or ARM (Amazon Linux 2)

## 1.) run ./setupInitial.sh to configure OS environment

## 2.) configure your ~/.aws credentials

## 3.) run ./setupBLD-IN.sh to pull in the IN directory from S3

## 4.) Setup Src builds for PGBIN in devel/pgbin/build
###    - libSrcBuilds.sh
###    - gisSrcBuilds.sh
###    - buildBoost.sh
###    - On AMD only:
####     - installOracleInstantClient.sh
####     - installCppDriver.sh
###    - sharedLibs.sh

